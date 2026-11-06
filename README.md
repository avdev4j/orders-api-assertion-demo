# orders-api-assertion-demo

A tiny Orders API used to show one idea: **an assertion message is a prompt for the agent that fixes your CI.**

Two Postman collections run the **same request** with the **same assertion**. Only the message differs.

| Collection | Test name | Message the agent reads |
| --- | --- | --- |
| `orders-unhelpful` | `Response has orderId` | `expected { id: 'ord_123', … } to have property 'orderId'` |
| `orders-helpful` | `GET /orders/{id} returns 'orderId'` | `Response is missing 'orderId'. The OpenAPI spec defines it as a required string.` |

`openapi.yaml` is the source of truth: `Order.orderId` is a required string.

## Run it locally

```bash
npm install
npm run start            # API on :3000
npm run test:unhelpful   # in another terminal
npm run test:helpful
# or everything in one go:
./scripts/run-local.sh
```

Both pass on `main`.

## Recording the video

1. Push `main`: both CI jobs are green.
2. Create a branch, then break the API: `./scripts/introduce-bug.sh` (the API now returns `id` instead of `orderId`).
3. Open a PR: **both jobs fail**, with different messages.
4. Grab two screenshots or clips of the failing logs (job `unhelpful` and job `helpful`).
5. Optional: let your agent (for example Claude Code auto-fix on the PR) fix each variant and compare what it changes. The spec says `orderId`, so the right fix is in `src/server.js`, not in the assertion.

## Notes

- The workflow uses Newman so it runs with no secrets. A commented Postman CLI alternative is included.
- One run per case: this is an illustration, not a benchmark.
