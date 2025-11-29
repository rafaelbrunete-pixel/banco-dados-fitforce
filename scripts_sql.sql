-- 1. Primeiro, criamos os produtos (Planos)
INSERT INTO PLANO (Nome_Plano, Valor, Duracao_Meses) VALUES 
('Mensal', 100.00, 1),
('Trimestral', 270.00, 3),
('Anual', 900.00, 12);

-- 2. Contratamos os instrutores
INSERT INTO INSTRUTOR (Nome, Email, Especialidade) VALUES 
('Carlos Silva', 'carlos@fitforce.com', 'Musculação'),
('Fernanda Lima', 'fernanda@fitforce.com', 'Yoga'),
('Roberto Souza', 'roberto@fitforce.com', 'Crossfit');

-- 3. Agora podemos matricular Alunos (Veja que usamos o ID do plano aqui)
INSERT INTO ALUNO (Nome, CPF, Data_Nascimento, ID_Plano) VALUES 
('João da Silva', '111.111.111-11', '1990-05-15', 1), -- Plano Mensal
('Maria Oliveira', '222.222.222-22', '1985-10-20', 3), -- Plano Anual
('Pedro Santos', '333.333.333-33', '2000-01-10', 1);  -- Plano Mensal

-- 4. Definimos as Aulas (Ligando ao Instrutor)
INSERT INTO AULA (Nome_Aula, Horario_Inicio, Capacidade_Max, ID_Instrutor) VALUES 
('Yoga Manhã', '08:00:00', 15, 2), -- Instrutora Fernanda
('Crossfit Noite', '19:00:00', 20, 3); -- Instrutor Roberto

-- 5. Adicionamos Telefones (Para testar 1FN)
INSERT INTO ALUNO_TELEFONE (ID_Aluno, Telefone) VALUES 
(1, '(11) 99999-1111'),
(2, '(11) 98888-2222');

-- 6. Geramos Pagamentos
INSERT INTO PAGAMENTO (ID_Aluno, Data_Pagamento, Valor_Pago, Status) VALUES 
(1, '2025-11-01', 100.00, 'Pago'),
(2, '2025-11-05', 900.00, 'Pago'),
(3, '2025-11-10', 100.00, 'Pendente'); -- Pedro ainda não pagou

-- 7. Registramos Frequência
INSERT INTO FREQUENCIA (ID_Aluno, Data_Entrada, Hora_Entrada, Hora_Saida) VALUES 
(1, '2025-11-20', '18:00:00', '19:00:00');

-- 8. Fazemos um Agendamento (Aluno João na aula de Yoga)
INSERT INTO AGENDAMENTO (ID_Aluno, ID_Aula, Data_Agendamento, Status_Reserva) VALUES 
(1, 1, '2025-11-21', 'Confirmado');
-- Pergunta 1: Quem são os alunos que estão devendo? (Uso de WHERE)
SELECT Nome, CPF 
FROM ALUNO 
JOIN PAGAMENTO ON ALUNO.ID_Aluno = PAGAMENTO.ID_Aluno
WHERE PAGAMENTO.Status = 'Pendente';

-- Pergunta 2: Quero ver todos os alunos e quais planos eles contrataram. (Uso de JOIN)
SELECT ALUNO.Nome, PLANO.Nome_Plano, PLANO.Valor
FROM ALUNO
INNER JOIN PLANO ON ALUNO.ID_Plano = PLANO.ID_Plano;

-- Pergunta 3: Qual é a aula, que horas começa e quem é o professor? (JOIN triplo)
SELECT AULA.Nome_Aula, AULA.Horario_Inicio, INSTRUTOR.Nome
FROM AULA
INNER JOIN INSTRUTOR ON AULA.ID_Instrutor = INSTRUTOR.ID_Instrutor;
-- --- ATUALIZAÇÕES (UPDATE) ---

-- Cenario 1: Inflação! O plano mensal subiu para 110 reais.
UPDATE PLANO 
SET Valor = 110.00 
WHERE Nome_Plano = 'Mensal';

-- Cenario 2: O Pedro pagou a mensalidade atrasada. Vamos mudar o status.
UPDATE PAGAMENTO 
SET Status = 'Pago' 
WHERE ID_Aluno = 3;

-- Cenario 3: A aula de Crossfit mudou de capacidade. Cabe mais gente.
UPDATE AULA 
SET Capacidade_Max = 25 
WHERE Nome_Aula = 'Crossfit Noite';


-- --- EXCLUSÕES (DELETE) ---

-- Cenario 1: O agendamento do João foi cancelado.
DELETE FROM AGENDAMENTO 
WHERE ID_Agendamento = 1;

-- Cenario 2: O aluno Pedro trocou de telefone. Apagamos o antigo.
-- (Supondo que ele tinha esse telefone cadastrado, senão o comando roda mas não apaga nada)
DELETE FROM ALUNO_TELEFONE 
WHERE ID_Aluno = 3;

-- Cenario 3: Um instrutor saiu da academia. 
-- CUIDADO: Se ele tiver aulas cadastradas, o banco pode travar a exclusão por segurança.
-- Vamos deletar um instrutor fictício que não tem aula para evitar erro.
DELETE FROM INSTRUTOR 
WHERE Nome = 'Instrutor Teste Que Saiu';
