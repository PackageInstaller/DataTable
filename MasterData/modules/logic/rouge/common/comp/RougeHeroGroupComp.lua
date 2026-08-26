-- chunkname: @modules/logic/rouge/common/comp/RougeHeroGroupComp.lua

module("modules.logic.rouge.common.comp.RougeHeroGroupComp", package.seeall)

local RougeHeroGroupComp = class("RougeHeroGroupComp", UserDataDispose)

function RougeHeroGroupComp.Get(go)
	local comp = RougeHeroGroupComp.New()

	comp:init(go)

	return comp
end

function RougeHeroGroupComp:init(go)
	self:__onInit()

	self.go = go

	self:_editableInitView()
end

function RougeHeroGroupComp:_editableInitView()
	self._btnMember = gohelper.findChildButtonWithAudio(self.go, "Root/#btn_Member")
	self._goRecovery = gohelper.findChild(self.go, "Root/recovery")
	self._goLossLife = gohelper.findChild(self.go, "Root/bleeding")

	gohelper.setActive(self._goRecovery, false)
	gohelper.setActive(self._goLossLife, false)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onTeamLifeChange, self.onLifeChange, self)
end

function RougeHeroGroupComp:onLifeChange(status)
	if status == RougeMapEnum.LifeChangeStatus.Idle then
		return
	end

	if status == RougeMapEnum.LifeChangeStatus.Add then
		gohelper.setActive(self._goRecovery, false)
		gohelper.setActive(self._goRecovery, true)

		return
	end

	gohelper.setActive(self._goLossLife, false)
	gohelper.setActive(self._goLossLife, true)
end

function RougeHeroGroupComp:_btnMemberOnClick()
	RougeController.instance:openRougeTeamView()
end

function RougeHeroGroupComp:onOpen()
	self._btnMember:AddClickListener(self._btnMemberOnClick, self)
end

function RougeHeroGroupComp:onClose()
	self._btnMember:RemoveClickListener()
end

function RougeHeroGroupComp:destroy()
	self:__onDispose()
end

return RougeHeroGroupComp
