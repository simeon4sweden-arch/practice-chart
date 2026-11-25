create table if not exists public.practice_cloud_v6 (
 user_id uuid primary key references auth.users(id) on delete cascade,
 revision uuid not null,
 snapshot jsonb not null
);
alter table public.practice_cloud_v6 enable row level security;
revoke all on public.practice_cloud_v6 from anon;
grant select, insert, update on public.practice_cloud_v6 to authenticated;
create policy "v6 read own" on public.practice_cloud_v6 for select to authenticated using ((select auth.uid()) = user_id);
create policy "v6 insert own" on public.practice_cloud_v6 for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "v6 update own" on public.practice_cloud_v6 for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
