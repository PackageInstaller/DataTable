-- baoruichang
-- 2023/6/2 11:48:44
local UIKitChenPopCtrl = BaseClass("UIKitChenPopCtrl", BaseUICtrl)
local M = UIKitChenPopCtrl

function M:Init()
    self._view.btn_cancle:onClick(Bind(self, self.Close))
    self._view.btn_confirm:onClick(Bind(self, self._onBtnOkClick))
    self._view.btn_mask:onClick(Bind(self, self.Close))
    self._view.ComNumSliderCtrl:SetChangedCallback(Bind(self, self._onSliderValueClick))
end

-- 进入UI，可传参数
function M:OnEnter(foodId, num, callBack)
    self.callBack = callBack
    self._view.txt_name:SetItemName(foodId)
    self._view.img_icon:SetItemIcon(foodId)
    self._view.ComNumSliderCtrl:SetSliderInfo(num, num, 1)
end

function M:_onBtnOkClick()
    if self.callBack then
        self.callBack(self.selectNum)
        self:Close()
    end
end

function M:_onSliderValueClick(value)
    self.selectNum = value
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return UIKitChenPopCtrl
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

