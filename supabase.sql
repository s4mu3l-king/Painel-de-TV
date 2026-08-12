create table if not exists public.tv_playlist (id bigint primary key, items jsonb not null default '[]'::jsonb, updated_at timestamptz not null default now());
insert into public.tv_playlist(id,items) values(1,'[]'::jsonb) on conflict(id) do nothing;
alter table public.tv_playlist enable row level security;
create policy "tv_read" on public.tv_playlist for select to anon using(true);
create policy "tv_insert" on public.tv_playlist for insert to anon with check(id=1);
create policy "tv_update" on public.tv_playlist for update to anon using(id=1) with check(id=1);