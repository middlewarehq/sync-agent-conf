-- migrate:up

CREATE TABLE public."CodeRepo"(
    id uuid NOT NULL,
    key character varying(127) NOT NULL,
    name character varying(255) NOT NULL,
    org_name character varying(255) NOT NULL,
    provider character varying(63) NOT NULL,
    languages jsonb NOT NULL DEFAULT '{}'::jsonb,
    contributors jsonb NOT NULL DEFAULT '{}'::jsonb,
    meta jsonb NOT NULL DEFAULT '{}'::jsonb,
    is_sync_enabled boolean NOT NULL DEFAULT false,
    created_in_db_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_in_db_at timestamp with time zone NOT NULL DEFAULT now()
);

ALTER TABLE public."CodeRepo" ADD CONSTRAINT "CodeRepo_pkey" PRIMARY KEY (id);

CREATE UNIQUE INDEX "CodeRepo_key" ON public."CodeRepo" USING btree (key);

CREATE INDEX "CodeRepo_provider" ON public."CodeRepo" USING btree (provider);


CREATE TABLE public."CodeRepoBookmark" (
    repo_id uuid NOT NULL,
    provider character varying(63) NOT NULL,
    bookmark timestamp with time zone NOT NULL,
    created_in_db_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_in_db_at timestamp with time zone NOT NULL DEFAULT now()
);

ALTER TABLE public."CodeRepoBookmark" ADD CONSTRAINT "CodeRepoBookmark_pkey" PRIMARY KEY (repo_id);

ALTER TABLE public."CodeRepoBookmark" ADD CONSTRAINT "CodeRepoBookmark_repo_id_fkey" FOREIGN KEY (repo_id) REFERENCES public."CodeRepo"(id) ON DELETE CASCADE;


CREATE TABLE public."CodeUser" (
    name character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    provider character varying(63) NOT NULL,
    meta jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_in_db_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_in_db_at timestamp with time zone NOT NULL DEFAULT now()
);

ALTER TABLE public."CodeUser" ADD CONSTRAINT "CodeUser_pkey" PRIMARY KEY (username, provider);


CREATE TABLE public."PullRequest" (
    id uuid NOT NULL,
    repo_id uuid NOT NULL,
    number integer NOT NULL,
    provider character varying(63) NOT NULL,
    meta jsonb NOT NULL DEFAULT '{}'::jsonb,
    additions integer,
    deletions integer,
    files_changed integer,
    sent_to_mhq boolean NOT NULL DEFAULT false,
    created_in_db_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_in_db_at timestamp with time zone NOT NULL DEFAULT now()
);

ALTER TABLE public."PullRequest" ADD CONSTRAINT "PullRequest_pkey" PRIMARY KEY (id);

ALTER TABLE public."PullRequest" ADD CONSTRAINT "PullRequest_repo_id_fkey" FOREIGN KEY (repo_id) REFERENCES public."CodeRepo"(id) ON DELETE CASCADE;


CREATE TABLE public."PullRequestEvent" (
    pr_id uuid NOT NULL,
    id character varying(255) NOT NULL,
    meta jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_in_db_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_in_db_at timestamp with time zone NOT NULL DEFAULT now()
);

ALTER TABLE public."PullRequestEvent" ADD CONSTRAINT "PullRequestEvent_pkey" PRIMARY KEY (pr_id, id);

ALTER TABLE public."PullRequestEvent" ADD CONSTRAINT "PullRequestEvent_pr_id_fkey" FOREIGN KEY (pr_id) REFERENCES public."PullRequest"(id) ON DELETE CASCADE;


CREATE TABLE public."PullRequestCommit" (
    pr_id uuid NOT NULL,
    hash character varying(255) NOT NULL,
    meta jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_in_db_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_in_db_at timestamp with time zone NOT NULL DEFAULT now()
);

ALTER TABLE public."PullRequestCommit" ADD CONSTRAINT "PullRequestCommit_pkey" PRIMARY KEY (pr_id, hash);

ALTER TABLE public."PullRequestCommit" ADD CONSTRAINT "PullRequestCommit_pr_id_fkey" FOREIGN KEY (pr_id) REFERENCES public."PullRequest"(id) ON DELETE CASCADE;


CREATE TABLE public."SystemLog" (
    id uuid NOT NULL,
    type character varying(63) NOT NULL,
    message jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_in_db_at timestamp with time zone NOT NULL DEFAULT now()
);

ALTER TABLE public."SystemLog" ADD CONSTRAINT "SystemLog_pkey" PRIMARY KEY (id);

CREATE INDEX "SystemLog_type" ON public."SystemLog" USING btree (type);

CREATE INDEX "SystemLog_created_in_db_at" ON public."SystemLog" USING btree (created_in_db_at);

-- migrate:down

