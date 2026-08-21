-- baoruichang
-- 2023/5/19 16:23:18
local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIRoleSkillUpItemCtrl = BaseClass("UIRoleSkillUpItemCtrl", CircularScrollViewItem)
local M = UIRoleSkillUpItemCtrl

function M:Init()
end

function M:UpdateItem(data)
    self._view.imgIcon:SetPic(data.icon)
    self._view.labName:SetText(data.name)
    self._view.labDesc:SetText(data.desc)
    self._view.labValue1:SetText(data.curValue)
    self._view.labValue2:SetText(data.nextValue)
end

return UIRoleSkillUpItemCtrl
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
--                            《偈》
--                         平生不修善果
--                         只爱杀人放火
--                         忽地顿开金绳
--                         这里扯断玉锁
--                         钱塘江上潮信来
--                         今日方知我是我
