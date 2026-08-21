local M = BaseClass("WordShowUICtrl", BaseUICtrl)
local CSCloseBattleMasterUI = CS.GameX.Battle.Event.CloseBattleMasterUI
local CloseBattleMasterUI = CSCloseBattleMasterUI()
function M:__init()
    self._view.img_close:onClick(Bind(self, self._OnClick))
    self.globalTargetDesc = IBattle.context.missionData.Stage.globalTargetDesc
    local count = self.globalTargetDesc.Length
    for i = 1, count do
        local wordInfo = UIUtil.GetChild(self._view.WordInfoRoot,i-1)
        local des = UIUtil.FindText(wordInfo,"txt_Des")
        des:SetText(ConfigHelper.GetLocalString(self.globalTargetDesc[i-1]))
    end
    self._view.UIState:SetState(count+1)
end

function M:_OnClick()
    CloseBattleMasterUI.closeUiName = self._strName
    IGameEventMgr:SendEventByLua(CloseBattleMasterUI)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
