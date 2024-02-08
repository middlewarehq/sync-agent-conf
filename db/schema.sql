SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: CodeRepo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CodeRepo" (
    id uuid NOT NULL,
    key character varying(127) NOT NULL,
    name character varying(255) NOT NULL,
    org_name character varying(255) NOT NULL,
    provider character varying(63) NOT NULL,
    languages jsonb DEFAULT '{}'::jsonb NOT NULL,
    contributors jsonb DEFAULT '{}'::jsonb NOT NULL,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    is_sync_enabled boolean DEFAULT false NOT NULL,
    created_in_db_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_in_db_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: CodeRepoBookmark; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CodeRepoBookmark" (
    repo_id uuid NOT NULL,
    provider character varying(63) NOT NULL,
    bookmark timestamp with time zone NOT NULL,
    created_in_db_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_in_db_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: CodeUser; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CodeUser" (
    name character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    provider character varying(63) NOT NULL,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_in_db_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_in_db_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: MHQCommands; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."MHQCommands" (
    id uuid NOT NULL,
    command character varying(255) NOT NULL,
    parameters json DEFAULT '{}'::json NOT NULL,
    created_at timestamp with time zone NOT NULL,
    is_executed boolean DEFAULT false NOT NULL
);


--
-- Name: PullRequest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PullRequest" (
    id uuid NOT NULL,
    repo_id uuid NOT NULL,
    number integer NOT NULL,
    provider character varying(63) NOT NULL,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    additions integer,
    deletions integer,
    files_changed integer,
    sent_to_mhq boolean DEFAULT false NOT NULL,
    created_in_db_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_in_db_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: PullRequestCommit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PullRequestCommit" (
    pr_id uuid NOT NULL,
    hash character varying(255) NOT NULL,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_in_db_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_in_db_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: PullRequestEvent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PullRequestEvent" (
    pr_id uuid NOT NULL,
    id character varying(255) NOT NULL,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_in_db_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_in_db_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: SystemLog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SystemLog" (
    id uuid NOT NULL,
    type character varying(63) NOT NULL,
    message jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_in_db_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: CodeRepoBookmark CodeRepoBookmark_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CodeRepoBookmark"
    ADD CONSTRAINT "CodeRepoBookmark_pkey" PRIMARY KEY (repo_id);


--
-- Name: CodeRepo CodeRepo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CodeRepo"
    ADD CONSTRAINT "CodeRepo_pkey" PRIMARY KEY (id);


--
-- Name: CodeUser CodeUser_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CodeUser"
    ADD CONSTRAINT "CodeUser_pkey" PRIMARY KEY (username, provider);


--
-- Name: MHQCommands Commands_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MHQCommands"
    ADD CONSTRAINT "Commands_pkey" PRIMARY KEY (id);


--
-- Name: PullRequestCommit PullRequestCommit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PullRequestCommit"
    ADD CONSTRAINT "PullRequestCommit_pkey" PRIMARY KEY (pr_id, hash);


--
-- Name: PullRequestEvent PullRequestEvent_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PullRequestEvent"
    ADD CONSTRAINT "PullRequestEvent_pkey" PRIMARY KEY (pr_id, id);


--
-- Name: PullRequest PullRequest_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PullRequest"
    ADD CONSTRAINT "PullRequest_pkey" PRIMARY KEY (id);


--
-- Name: SystemLog SystemLog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SystemLog"
    ADD CONSTRAINT "SystemLog_pkey" PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: CodeRepo_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "CodeRepo_key" ON public."CodeRepo" USING btree (key);


--
-- Name: CodeRepo_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CodeRepo_provider" ON public."CodeRepo" USING btree (provider);


--
-- Name: SystemLog_created_in_db_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "SystemLog_created_in_db_at" ON public."SystemLog" USING btree (created_in_db_at);


--
-- Name: SystemLog_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "SystemLog_type" ON public."SystemLog" USING btree (type);


--
-- Name: CodeRepoBookmark CodeRepoBookmark_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CodeRepoBookmark"
    ADD CONSTRAINT "CodeRepoBookmark_repo_id_fkey" FOREIGN KEY (repo_id) REFERENCES public."CodeRepo"(id) ON DELETE CASCADE;


--
-- Name: PullRequestCommit PullRequestCommit_pr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PullRequestCommit"
    ADD CONSTRAINT "PullRequestCommit_pr_id_fkey" FOREIGN KEY (pr_id) REFERENCES public."PullRequest"(id) ON DELETE CASCADE;


--
-- Name: PullRequestEvent PullRequestEvent_pr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PullRequestEvent"
    ADD CONSTRAINT "PullRequestEvent_pr_id_fkey" FOREIGN KEY (pr_id) REFERENCES public."PullRequest"(id) ON DELETE CASCADE;


--
-- Name: PullRequest PullRequest_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PullRequest"
    ADD CONSTRAINT "PullRequest_repo_id_fkey" FOREIGN KEY (repo_id) REFERENCES public."CodeRepo"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20231219100651'),
    ('20240203103438');
