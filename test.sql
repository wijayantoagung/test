INSERT INTO `dashboard_mau`( `month`, `year`, `total_user_login`, `total_users`, `value`, `source`, `core`, `created_on`) VALUES 
(
    (DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH),'%m')), 
    (DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH),'%Y')),
    (
    	SELECT COUNT(DISTINCT(gmedes_lite.log_login.user_id)) as total
		FROM gmedes_lite.log_login
		INNER JOIN gmedes_lite.sites ON gmedes_lite.sites.site_id = gmedes_lite.log_login.site_id
		INNER JOIN gmedes_lite.site_settings ON gmedes_lite.site_settings.setting_group = gmedes_lite.sites.setting_group
		WHERE gmedes_lite.site_settings.field = 'country' AND gmedes_lite.site_settings.value = 'Singapore' 
		AND gmedes_lite.log_login.role = "merchant"
		AND YEAR(gmedes_lite.log_login.login_date) = DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH),'%Y')
    	AND MONTH(gmedes_lite.log_login.login_date) = DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH),'%m')
	),
    (
    	SELECT COUNT(user_id) FROM gmedes_lite.users 
		INNER JOIN gmedes_lite.sites ON gmedes_lite.sites.site_id = gmedes_lite.users.site_id
		INNER JOIN gmedes_lite.site_settings ON gmedes_lite.site_settings.setting_group = gmedes_lite.sites.setting_group
		WHERE roles = 'merchant' AND gmedes_lite.site_settings.field = 'country' AND gmedes_lite.site_settings.value = 'Singapore'
 	),
    (
    	(
    		SELECT COUNT(DISTINCT(gmedes_lite.log_login.user_id)) as total
			FROM gmedes_lite.log_login
			INNER JOIN gmedes_lite.sites ON gmedes_lite.sites.site_id = gmedes_lite.log_login.site_id
			INNER JOIN gmedes_lite.site_settings ON gmedes_lite.site_settings.setting_group = gmedes_lite.sites.setting_group
			WHERE gmedes_lite.site_settings.field = 'country' AND gmedes_lite.site_settings.value = 'Singapore' 
			AND gmedes_lite.log_login.role = "merchant"
			AND YEAR(gmedes_lite.log_login.login_date) = DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH),'%Y')
			AND MONTH(gmedes_lite.log_login.login_date) = DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH),'%m')
		)
        /
        (
        	SELECT COUNT(user_id) FROM gmedes_lite.users 
			INNER JOIN gmedes_lite.sites ON gmedes_lite.sites.site_id = gmedes_lite.users.site_id
			INNER JOIN gmedes_lite.site_settings ON gmedes_lite.site_settings.setting_group = gmedes_lite.sites.setting_group
			WHERE roles = 'merchant' AND gmedes_lite.site_settings.field = 'country' AND gmedes_lite.site_settings.value = 'Singapore'
 		)
    ),
    'LITE',
    'SG',
    now()
)