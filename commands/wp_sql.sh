# vim:syntax=sql

wp db query "show table status like 'wp_options'\G"
wp db query "select distinct order_item_id from wp_woocommerce_order_itemmeta where meta_value=105"
wp db query "select * from wp_woocommerce_order_itemmeta where order_item_id IN (select distinct order_item_id from wp_woocommerce_order_itemmeta where meta_value=105)"
wp db query "select * from wp_postmeta where meta_key='Total Donation Amount' AND meta_value='0'"
wp cli
  "SELECT * FROM table \G" ; forces vertical mode

mysqldump --single-transaction  -u om_site_usr -p one_mission_wp > ~/backup/om_$(date).sql
mysqldump --single-transaction  -u om_site_usr -p one_mission_wp wp_woocommerce_order_itemmeta > ~/backup/om_woocommerce.sql
mysql -u om_site_usr -p one_mission_dev < ~/backup/om_woocommerce.sql
"SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' and TABLE_SCHEMA='one_mission_dev'"

mysqldump --single-transaction  -u om_site_usr -p one_mission_wp \
  wp_commentmeta \
  wp_comments \
  wp_gf_addon_feed \
  wp_gglcptch_whitelist \
  wp_hook_list \
  wp_links \
  wp_postmeta \
  wp_posts \
  wp_signups \
  wp_term_relationships \
  wp_term_taxonomy \
  wp_termmeta \
  wp_terms \
  wp_usermeta \
  wp_users \
  wp_woocommerce_api_keys \
  wp_woocommerce_attribute_taxonomies \
  wp_woocommerce_downloadable_product_permissions \
  wp_woocommerce_log \
  wp_woocommerce_order_itemmeta \
  wp_woocommerce_order_items \
  wp_woocommerce_payment_tokenmeta \
  wp_woocommerce_payment_tokens \
  wp_woocommerce_sessions \
  wp_woocommerce_shipping_zone_locations \
  wp_woocommerce_shipping_zone_methods \
  wp_woocommerce_shipping_zones \
  wp_woocommerce_tax_rate_locations \
  wp_woocommerce_tax_rates \
  wp_woocommerce_termmeta \
  wp_wsluserscontacts \
  wp_wslusersprofiles \
> ~/backup/om_livedb_$(date +%F.%H-%M).sql

,#n-,BP2_HXusG.Tp&!w

# vim: syn=sql
GRANT SELECT, INSERT, UPDATE, DROP, DELETE, CREATE, REFERENCES, INDEX, ALTER, EXECUTE, CREATE VIEW, SHOW VIEW, ALTER ROUTINE, TRIGGER ON `one\_mission\_dev`.* TO 'om_site_usr'@'localhost' IDENTIFIED BY 'YOEebwNHmPgmQrhb9BAH';
GRANT ALL PRIVILEGES ON *.* 'om_site_usr'@'localhost' IDENTIFIED BY 'YOEebwNHmPgmQrhb9BAH' WITH GRANT OPTION;


SELECT DISTINCT post_id from wp_postmeta WHERE post_id IN (SELECT DISTINCT post_id FROM wp_postmeta WHERE meta_key='Total Donation Amount' AND meta_value='0');

SELECT * from wp_postmeta WHERE post_id in (SELECT distinct post_id from wp_postmeta where meta_key='Total Donation Amount' AND meta_value='0') AND meta_key='_order_total';

SELECT distinct post_id from wp_postmeta WHERE post_id in (SELECT distinct post_id from wp_postmeta where meta_key='Total Donation Amount' AND meta_value='0') AND meta_key='_order_total'AND meta_value='105.00';

UPDATE wp_postmeta SET meta_value='105.00' WHERE meta_key='Total Donation Amount' AND post_id IN (select distinct post_id from (SELECT * FROM wp_postmeta) AS wp_postmeta2 WHERE post_id in (select distinct post_id from (SELECT * FROM wp_postmeta) AS wp_postmeta3 where meta_key='Total Donation Amount' AND meta_value='0') AND meta_key='_order_total'AND meta_value='105.00');

wp_commentmeta
wp_comments
wp_links
wp_options
wp_postmeta
wp_posts
wp_termmeta
wp_term_relationships
wp_terms
wp_term_taxonomy
wp_usermeta
wp_users
wp_woocommerce_order_itemmeta
wp_woocommerce_payment_tokenmeta

" Products are located mainly in 2 tables:
wp_posts table with a post_type like product or product_variation,
wp_postmeta table with the corresponding post_id by product (the product ID).
Product types, categories, subcategories, tags, attributes and all other custom taxonomies are located in the following tables:

Orders are a Custom Post Type (CPT), so they are stored in the wp_posts table. If you search the post_type field for 'shop_order', SQL will retrieve all orders.
Then, you must search the wp_postmeta table for all the records with post_id matching the id of the order post. Among the fields you will then find in the wp_postmeta table will be the entire shipping and billing addresses.
"

select
    p.ID as order_id,
    p.post_date,
    max( CASE WHEN pm.meta_key = '_billing_email' and p.ID = pm.post_id THEN pm.meta_value END ) as billing_email,
    max( CASE WHEN pm.meta_key = '_billing_first_name' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_first_name,
    max( CASE WHEN pm.meta_key = '_billing_last_name' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_last_name,
    max( CASE WHEN pm.meta_key = '_billing_address_1' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_address_1,
    max( CASE WHEN pm.meta_key = '_billing_address_2' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_address_2,
    max( CASE WHEN pm.meta_key = '_billing_city' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_city,
    max( CASE WHEN pm.meta_key = '_billing_state' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_state,
    max( CASE WHEN pm.meta_key = '_billing_postcode' and p.ID = pm.post_id THEN pm.meta_value END ) as _billing_postcode,
    max( CASE WHEN pm.meta_key = '_shipping_first_name' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_first_name,
    max( CASE WHEN pm.meta_key = '_shipping_last_name' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_last_name,
    max( CASE WHEN pm.meta_key = '_shipping_address_1' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_address_1,
    max( CASE WHEN pm.meta_key = '_shipping_address_2' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_address_2,
    max( CASE WHEN pm.meta_key = '_shipping_city' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_city,
    max( CASE WHEN pm.meta_key = '_shipping_state' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_state,
    max( CASE WHEN pm.meta_key = '_shipping_postcode' and p.ID = pm.post_id THEN pm.meta_value END ) as _shipping_postcode,
    max( CASE WHEN pm.meta_key = '_order_total' and p.ID = pm.post_id THEN pm.meta_value END ) as order_total,
    max( CASE WHEN pm.meta_key = '_order_tax' and p.ID = pm.post_id THEN pm.meta_value END ) as order_tax,
    max( CASE WHEN pm.meta_key = '_paid_date' and p.ID = pm.post_id THEN pm.meta_value END ) as paid_date,
    ( select group_concat( order_item_name separator '|' ) from wp_woocommerce_order_items where order_id = p.ID ) as order_items
from
    wp_posts p
    join wp_postmeta pm on p.ID = pm.post_id
    join wp_woocommerce_order_items oi on p.ID = oi.order_id
where
    post_type = 'shop_order' and
    post_date BETWEEN '2015-01-01' AND '2015-07-08' and
    post_status = 'wc-completed' and
    oi.order_item_name = 'Product Name'
group by
    p.ID
"
wp_404_to_301
wp_bsearch
wp_bsearch_daily
wp_commentmeta
wp_comments
wp_cpk_wpcsv_export_queue
wp_cpk_wpcsv_log
wp_gf_addon_feed
wp_gglcptch_whitelist
wp_hook_list
wp_links
wp_options
wp_postmeta
wp_posts
wp_rg_form
wp_rg_form_meta
wp_rg_form_view
wp_rg_incomplete_submissions
wp_rg_lead
wp_rg_lead_detail
wp_rg_lead_detail_long
wp_rg_lead_meta
wp_rg_lead_notes
wp_rg_userregistration
wp_signups
wp_term_relationships
wp_term_taxonomy
wp_termmeta
wp_terms
wp_usermeta
wp_users
wp_wfBadLeechers
wp_wfBlockedIPLog
wp_wfBlocks
wp_wfBlocksAdv
wp_wfConfig
wp_wfCrawlers
wp_wfFileChanges
wp_wfFileMods
wp_wfHits
wp_wfHoover
wp_wfIssues
wp_wfLeechers
wp_wfLockedOut
wp_wfLocs
wp_wfLogins
wp_wfNet404s
wp_wfReverseCache
wp_wfScanners
wp_wfStatus
wp_wfThrottleLog
wp_wfVulnScanners
wp_woocommerce_api_keys
wp_woocommerce_attribute_taxonomies
wp_woocommerce_downloadable_product_permissions
wp_woocommerce_log
wp_woocommerce_order_itemmeta
wp_woocommerce_order_items
wp_woocommerce_payment_tokenmeta
wp_woocommerce_payment_tokens
wp_woocommerce_sessions
wp_woocommerce_shipping_zone_locations
wp_woocommerce_shipping_zone_methods
wp_woocommerce_shipping_zones
wp_woocommerce_tax_rate_locations
wp_woocommerce_tax_rates
wp_woocommerce_termmeta
wp_wsluserscontacts
wp_wslusersprofiles


