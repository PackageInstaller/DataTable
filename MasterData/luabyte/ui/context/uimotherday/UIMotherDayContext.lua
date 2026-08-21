-- baoruichang
-- 2023/4/4 16:42:08
local UIMotherDayContext = BaseClass("UIMotherDayContext", BaseContext)
local M = UIMotherDayContext

function M:Open(activityId, callback)
    self.activityId = activityId
    self.m_CallBack = callback
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(activityId, Bind(self, self.AsynActCallBack))
end

function M:AsynActCallBack(data)
    if not data then
        data = {}
    end

    self:_Show(self.activityId, data[1], self.m_CallBack)
end

return UIMotherDayContext
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O\ = /O
--                        ____/`---'\____
--						  . ' \\| |// `.
--                       / \\||| : |||// \
--                     / _||||| -:- |||||- \
--                       | | \\\ - --/ | |
--                     | \_| ''\---/'' | |
--                      \ .-\__ `-` ___/-. /
--                   ___`. .' /--.--\ `. . __
--                ."" '< `.___\_<|>_/___.' >'"".
--               | | : `- \`.;`\ _ /`;.`/ - ` : | |
--                 \ \ `-. \_ __\ /__ _/ .-` / /
--         ======`-.____`-.___\_____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                  佛祖镇楼                  BUG辟易
--          佛曰:
--                  写字楼里写字间，写字间里程序员；
--                  程序人员写程序，又拿程序换酒钱。
--                  酒醒只在网上坐，酒醉还来网下眠；
--                  酒醉酒醒日复日，网上网下年复年。
--                  但愿老死电脑间，不愿鞠躬老板前；
--                  奔驰宝马贵者趣，公交自行程序员。
--                  别人笑我忒疯癫，我笑自己命太贱；
--                  不见满街漂亮妹，哪个归得程序员？

