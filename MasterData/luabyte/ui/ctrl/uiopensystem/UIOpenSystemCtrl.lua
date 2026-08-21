--baoruichang
--2022/12/13 15:42:30
--ComUnlockPopup
local UIOpenSystemCtrl = BaseClass("UIOpenSystemCtrl", BaseUICtrl)
local M = UIOpenSystemCtrl
local tInsert = table.insert

function M:Init()
    self._view.btnMark:onClick(Bind(self, self.Close))
    self.tabItems = {}
    tInsert(self.tabItems, self._view.UIOpenItemCtrl)
end

--进入UI，可传参数
function M:OnEnter(functionOpenIds)
    for i = 1, #functionOpenIds do
        local UIOpenItemCtrl = self.tabItems[i]
        if not UIOpenItemCtrl then
            UIOpenItemCtrl = self._view.UIOpenItemCtrl:Instantiate()
            tInsert(self.tabItems, UIOpenItemCtrl)
        end
        local functionOpen = ConfigHelper.GetCfg("functionOpen", functionOpenIds[i])
        UIOpenItemCtrl:UpdateData(functionOpen)
    end
end

function M:OnDispose()
    OpenSystemMgr:GetInstance():SetMissionId()
    for _, value in pairs(self.tabItems) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end
    M.super.OnDispose(self)
end

return UIOpenSystemCtrl

--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O\ = /O
--                        ____/`---'\____
--                      .   ' \\| |// `.
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
--                  不见满街漂亮妹，哪个归得程序员
