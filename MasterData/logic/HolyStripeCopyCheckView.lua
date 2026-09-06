-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/view/HolyStripeCopyCheckView.lua

module("logic.extensions.holystripecopy.view.HolyStripeCopyCheckView", package.seeall)

local HolyStripeCopyCheckView = class("HolyStripeCopyCheckView", ViewComponent)

function HolyStripeCopyCheckView:buildUI()
	HolyStripeCopyCheckView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnOk = self:getGo("btnOk")
	self._btnCancel = self:getGo("btnCancel")
	self._formations = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("formations/cell_" .. i)
		cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
		cell.petList = {}

		for k = 1, 9 do
			cell.petList[k] = goutil.findChild(cell.go, "pets/pet_" .. k .. "/pointPet")
		end

		self._formations[i] = cell
	end
end

function HolyStripeCopyCheckView:bindEvents()
	HolyStripeCopyCheckView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOk, self)
end

function HolyStripeCopyCheckView:unbindEvents()
	HolyStripeCopyCheckView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnOk)
end

function HolyStripeCopyCheckView:onEnter()
	HolyStripeCopyCheckView.super.onEnter(self)

	self._creepCfgs = self:getFirstParam()

	if not self._creepCfgs then
		return self:close()
	end

	self:refreshviewByCfg()
	GlobalDispatcher:addListener(GlobalNotify.HolyStripeCopyFormtionGet, self._onHandleGetFormation, self)
end

function HolyStripeCopyCheckView:onExit()
	HolyStripeCopyCheckView.super.onExit(self)

	for i = 1, 3 do
		for k = 1, 9 do
			MaterialMgr.resetAll(self._formations[i].petList[k])
		end
	end

	GlobalDispatcher:removeListener(GlobalNotify.HolyStripeCopyFormtionGet, self._onHandleGetFormation, self)
end

function HolyStripeCopyCheckView:_onClickOk()
	HolyStripeCopyController.instance:getLastForm(true)
end

function HolyStripeCopyCheckView:refreshviewByCfg()
	for i = 1, 3 do
		local cell = self._formations[i]

		cell.txtTitle.text = langPara("敌阵%s", i)

		local creepCfg = self._creepCfgs[i]
		local creeepMonsterCfgs = HolyStripeCopyConfig.instance:getCreepMonsterCfgs(creepCfg.creepsMasterId)

		for k, v in pairs(creeepMonsterCfgs) do
			local petMatStr = langPara("%s:%s:%s:0", MatType.Pet, v.raceId, v.lv)
			local proxy = MaterialMgr.setCellByCfg(petMatStr, cell.petList[v.posId])

			proxy.binder:setAutoTips(false)
		end
	end
end

function HolyStripeCopyCheckView:_onHandleGetFormation(isTeam)
	if isTeam then
		local mo = HolyStripeCopyModel.instance:getTeamCustomFmtMo()

		CustomFmtController.instance:showMissionFormationView(mo)
		self:close()
	end
end

return HolyStripeCopyCheckView
