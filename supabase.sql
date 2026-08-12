CREATE TABLE IF NOT EXISTS public.tv_playlist (
    id BIGINT PRIMARY KEY,
    items JSONB NOT NULL DEFAULT '[]'::jsonb,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Cria o registro inicial
INSERT INTO public.tv_playlist (id, items)
VALUES (1, '[]'::jsonb)
ON CONFLICT (id) DO NOTHING;

-- Ativa RLS
ALTER TABLE public.tv_playlist ENABLE ROW LEVEL SECURITY;

-- Remove as políticas antigas, caso já existam
DROP POLICY IF EXISTS "tv_read" ON public.tv_playlist;
DROP POLICY IF EXISTS "tv_insert" ON public.tv_playlist;
DROP POLICY IF EXISTS "tv_update" ON public.tv_playlist;

-- Permite que a TV leia a playlist
CREATE POLICY "tv_read"
ON public.tv_playlist
FOR SELECT
TO anon
USING (true);

-- Permite inserir somente o registro ID 1
CREATE POLICY "tv_insert"
ON public.tv_playlist
FOR INSERT
TO anon
WITH CHECK (id = 1);

-- Permite atualizar somente o registro ID 1
CREATE POLICY "tv_update"
ON public.tv_playlist
FOR UPDATE
TO anon
USING (id = 1)
WITH CHECK (id = 1);id=1) with check(id=1);