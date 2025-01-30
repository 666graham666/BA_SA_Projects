CREATE TABLE clients (
    id              VARCHAR(50) PRIMARY KEY,      -- Уникальный идентификатор клиента
    company_name    VARCHAR(255) NOT NULL,        -- Название компании
    inn             VARCHAR(12),                  -- ИНН
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW()
);



CREATE TABLE client_blocks (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    client_id       VARCHAR(50) NOT NULL,
    block_type      VARCHAR(50) NOT NULL,
    status          VARCHAR(20) NOT NULL,
    comment         TEXT,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by      VARCHAR(50),   -- информация о пользователе или системе, инициировавшей блокировку (необязательно)
    updated_by      VARCHAR(50),   -- информация о пользователе или системе, снявшей блокировку (необязательно)

    CONSTRAINT fk_client
        FOREIGN KEY (client_id) REFERENCES clients (id)
        ON DELETE CASCADE
);

 -- необязательно
 

CREATE TABLE block_events (
    event_id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    block_id        UUID NOT NULL,
    old_status      VARCHAR(20),
    new_status      VARCHAR(20),
    changed_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    changed_by      VARCHAR(50),
    reason          TEXT,          -- причина изменения
    CONSTRAINT fk_block
        FOREIGN KEY (block_id) REFERENCES client_blocks (id)
        ON DELETE CASCADE
);