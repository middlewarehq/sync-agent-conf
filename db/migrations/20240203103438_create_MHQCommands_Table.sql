-- migrate:up

CREATE TABLE public."MHQCommands"(
    id uuid NOT NULL,
    command character varying(255) NOT NULL, 
    parameters json DEFAULT '{}' NOT NULL,
    created_at timestamp with time zone NOT NULL, 
    is_executed boolean DEFAULT false NOT NULL 
);

ALTER TABLE ONLY public."MHQCommands"
    ADD CONSTRAINT "Commands_pkey" PRIMARY KEY (id);

-- migrate:down

