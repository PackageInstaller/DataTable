-- baoruichang
local UIDayEnergyItemCtrl = BaseClass("UIDayEnergyCtrl")
local M = UIDayEnergyItemCtrl

function M:__init(view)
    self._view = view
    self._view.btn:SetOnClick(Bind(self, self._OnClick))
end

function M:UpdateItem(data)
    self.data = data
    self._view.labTimer:SetText(data.startTime .. "-" .. data.endTime)
    local itemGroup = ConfigHelper.GetCfgByLua("itemGroup", data.award)
    self._view.ItemPfbUI:SetInfo(itemGroup.items[1], 1, itemGroup.cnts[1])
    self._view.ItemPfbUI:EnablePopItem(true)
    if data.state == 1 then -- 未开始
        self._view.labLock.transform.parent:SetActive(true)
        self._view.btn:SetActive(false)
        self._view.labLock:SetText(6263)
    elseif data.state == 2 then -- 可领取
        self._view.labLock.transform.parent:SetActive(false)
        self._view.btn:SetActive(true)
        self._view.btnState:SetState(1)
    elseif data.state == 3 then
        self._view.labLock.transform.parent:SetActive(true)
        self._view.btn:SetActive(false)
        self._view.labLock:SetText(6264)
    else
        self._view.labLock.transform.parent:SetActive(false)
        self._view.btn:SetActive(true)
        self._view.btnState:SetState(2)
    end
end

function M:SetOnClick(func)
    self.func = func
end

function M:_OnClick()
    if self.data.state ~= 2 then
        return
    end
    if self.func then
        self.func(self.data.id)
    end
end

function M:OnDispose()
    self._view.btn:RemoveOnClick()
    if self._view then
        self._view:OnDispose()
    end
end

return UIDayEnergyItemCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O. = /O
--                        ____/`---'.____
--						  . ' ..| |// `.
--                       / ..||| : |||// .
--                     / _||||| -:- |||||- .
--                       | | ... - --/ | |
--                     | ._| ''.---/'' | |
--                      . .-.__ `-` ___/-. /
--                   ___`. .' /--.--. `. . __
--                ."" '< `.___._<|>_/___.' >'"".
--               | | : `- .`.;`. _ /`;.`/ - ` : | |
--                 . . `-. ._ __. /__ _/ .-` / /
--         ======`-.____`-.___._____/___.-`____.-'======
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

