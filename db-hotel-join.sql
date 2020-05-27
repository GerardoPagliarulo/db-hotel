/***********
    JOIN
************/
-- Come si chiamano gli ospiti che hanno fatto più di due prenotazioni?
SELECT COUNT(`p_o`.`ospite_id`) AS `totale_prenotazioni`, `o`.`name`, `o`.`lastname`
FROM `prenotazioni_has_ospiti` AS `p_o`
INNER JOIN `ospiti` AS `o`
ON `p_o`.`ospite_id` = `o`.`id`
GROUP BY `p_o`.`ospite_id`
HAVING  COUNT(`p_o`.`ospite_id`) > 2;
-- Stampare tutti gli ospiti per ogni prenotazione
SELECT `p`.`id`, `o`.`name`, `o`.`lastname`
FROM `prenotazioni_has_ospiti` AS `p_o`
INNER JOIN `prenotazioni` AS `p`
ON `p_o`.`prenotazione_id` = `p`.`id`
INNER JOIN `ospiti` AS `o`
ON `p_o`.`ospite_id` = `o`.`id`;
-- Stampare Nome, Cognome, Prezzo e Pagante per tutte le prenotazioni fatte a Maggio 2018
SELECT `pag`.`name`, `pag`.`lastname`, `pg`.`price`, `p`.`created_at`
FROM `pagamenti` AS `pg`
INNER JOIN `prenotazioni` AS `p`
ON `pg`.`prenotazione_id` = `p`.`id`
INNER JOIN `paganti` AS `pag`
ON `pg`.`pagante_id` = `pag`.`id`
WHERE EXTRACT(YEAR_MONTH FROM `p`.`created_at`) = '201805';
-- Fai la somma di tutti i prezzi delle prenotazioni per le stanze del primo piano
SELECT SUM(`pg`.`price`) AS `tot_price_first_floor_room`
FROM `pagamenti` AS `pg`
INNER JOIN `prenotazioni` AS `p`
ON `pg`.`prenotazione_id` = `p`.`id`
WHERE `p`.`stanza_id` <= '6';
-- Le stanze sono state tutte prenotate almeno una volta? (Visualizzare le stanze non ancora prenotate)
SELECT `st`.`room_number`, `p`.`id` AS `prenotazioni`
FROM `stanze` AS `st`
LEFT JOIN `prenotazioni` AS `p`
ON `p`.`stanza_id` = `st`.`id`
WHERE  `p`.`stanza_id` IS NULL;
-- *
SELECT `st`.`room_number` AS `stanze`, `p`.`id` AS `prenotazioni_stanze`
FROM `stanze` AS `st`
LEFT JOIN `prenotazioni` AS `p`
ON `p`.`stanza_id` = `st`.`id`;
-- *
SELECT *
FROM `prenotazioni` AS `p`
RIGHT JOIN `stanze` AS `st`
ON `p`.`stanza_id` = `st`.`id`;
-- *
SELECT *
FROM `stanze` AS `st`
LEFT JOIN `prenotazioni` AS `p`
ON `p`.`stanza_id` = `st`.`id`;
/***************
    GROUP BY
***************/
-- Conta gli ospiti raggruppandoli per anno di nascita
SELECT YEAR(`date_of_birth`) AS `anno_di_nascita`, COUNT(id) AS `ospiti`
FROM `ospiti`
GROUP BY YEAR(`date_of_birth`);
-- Somma i prezzi dei pagamenti raggruppandoli per status
SELECT SUM(`price`) AS `tot_price_status`, `status`
FROM `pagamenti`
GROUP BY `status`;
-- Quante prenotazioni ha fatto l’ospite che ha fatto più prenotazioni?
SELECT COUNT(`prenotazioni_has_ospiti`.`id`) AS `numero_prenotazioni`, `ospiti`.`name`, `ospiti`.`lastname`
FROM `prenotazioni_has_ospiti`
INNER JOIN `ospiti`
ON `prenotazioni_has_ospiti`.`ospite_id` = `ospiti`.`id`
GROUP BY `ospite_id`
ORDER BY COUNT(`prenotazioni_has_ospiti`.`id`) DESC;
-- *
SELECT COUNT(`id`) AS `numero_prenotazioni_ospiti`
FROM `prenotazioni_has_ospiti`
GROUP BY `ospite_id`
ORDER BY COUNT(`id`) DESC;
