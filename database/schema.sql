-- AI Lead Capture & Qualification
-- Run once in the Supabase SQL Editor.

create table if not exists leads (
  -- Lead intake
  id                    uuid primary key default gen_random_uuid(),
  submission_id         text unique not null,   -- duplicate protection
  name                  text not null,
  email                 text not null,
  company               text,
  message               text not null,
  source                text,
  status                text not null default 'NEW',   -- business status
  created_at            timestamptz not null default now(),

  -- AI qualification
  ai_status             text not null default 'PENDING',  -- PENDING | SUCCESS | FAILED
  ai_error              text,                              -- error category only, never inquiry text
  services              text,                              -- comma-separated
  budget_status         text,                              -- stated | not_stated | unclear
  budget_min            numeric,
  budget_max            numeric,
  budget_currency       text,
  budget_period         text,                              -- monthly | one_time | hourly | unknown
  urgency               text,                              -- high | medium | low | unknown
  summary               text,
  missing_information   text,

  -- Priority and notifications
  priority              text not null default 'UNASSESSED', -- HIGH | MEDIUM | LOW | REVIEW
  notification_status   text not null default 'PENDING',     -- PENDING | SENT | FAILED
  acknowledgment_status text not null default 'PENDING',     -- PENDING | SENT | FAILED

  -- Retries
  retry_count           int not null default 0,              -- AI retries
  last_attempt_at       timestamptz,
  notify_attempts       int not null default 0,              -- agency email retries
  ack_attempts          int not null default 0,              -- acknowledgment retries
  retry_alerted         boolean not null default false       -- admin already alerted
);
