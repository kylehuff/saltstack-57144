cd $(dirname $(find /usr/lib -wholename '*/salt/master.py'))
cp master.py master.py.bak

cat << EOF | patch -Np1
--- old/master.py 
+++ new/master.py
@@ -1177,10 +1177,11 @@
         'verify_minion', '_master_tops', '_ext_nodes', '_master_opts',
         '_mine_get', '_mine', '_mine_delete', '_mine_flush', '_file_recv',
         '_pillar', '_minion_event', '_handle_minion_event', '_return',
-        '_syndic_return', '_minion_runner', 'pub_ret', 'minion_pub',
+        '_syndic_return', 'minion_runner', 'pub_ret', 'minion_pub',
         'minion_publish', 'revoke_auth', 'run_func', '_serve_file',
         '_file_find', '_file_hash', '_file_find_and_stat', '_file_list',
         '_file_list_emptydirs', '_dir_list', '_symlink_list', '_file_envs',
+        '_file_hash_and_stat',
     )

     def __init__(self, opts):
EOF
