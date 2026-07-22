import test from 'node:test';
import assert from 'node:assert/strict';

import { resolveApiURL } from '../../config.js';

test('resolveApiURL prefers an explicit API_URL', () => {
    assert.equal(resolveApiURL({ API_URL: 'https://api.example.com' }), 'https://api.example.com');
});

test('resolveApiURL uses Render external URL when available', () => {
    assert.equal(resolveApiURL({ RENDER_EXTERNAL_URL: 'https://render.example.com' }), 'https://render.example.com');
});

test('resolveApiURL falls back to localhost when no deployment URL is provided', () => {
    assert.equal(resolveApiURL({ PORT: '3000' }), 'http://127.0.0.1:3000');
});
