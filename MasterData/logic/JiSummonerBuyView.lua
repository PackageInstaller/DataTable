-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerBuyView.lua

module("logic.extensions.jisummoner.view.JiSummonerBuyView", package.seeall)

local JiSummonerBuyView = class("JiSummonerBuyView", ViewComponent)

function JiSummonerBuyView:ctor()
	JiSummonerBuyView.super.ctor(self)

	self._noOpenStr = ""
end

function JiSummonerBuyView:bindEvents()
	JiSummonerBuyView.super.bindEvents(self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(self._petRaceId)
	end, self)
	self._infoBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self._petRaceId)
	end, self)
	self._gotoBtn:AddClickListener(function()
		if not string.nilorempty(self._noOpenStr) then
			FloatWordMgr.instance:show(self._noOpenStr)

			return
		end

		if self._paramCfg and not string.nilorempty(self._paramCfg.skinGoto) then
			GotoMgr.gotoByString(self._paramCfg.skinGoto)
		end
	end, self)
end

function JiSummonerBuyView:unbindEvents()
	JiSummonerBuyView.super.unbindEvents(self)
	self._skillBtn:RemoveClickListener()
	self._infoBtn:RemoveClickListener()
	self._gotoBtn:RemoveClickListener()
end

function JiSummonerBuyView:onExit()
	JiSummonerBuyView.super.onExit(self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._updataSkinBuyOpen, self)

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._noOpenStr = ""
end

function JiSummonerBuyView:destroyUI()
	JiSummonerBuyView.super.destroyUI(self)
end

function JiSummonerBuyView:buildUI()
	JiSummonerBuyView.super.buildUI(self)

	self._sprineGo = self:getGo("sprineGo")

	local sprintInfoGo = self:getGo("sprintInfoGo")

	self._nameTxt = goutil.findChildTextComponent(sprintInfoGo, "nameTxt")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "skillBtn")
	self._infoBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "infoBtn")
	self._gotoBtn = self:getBtn("gotoBtn")
	self._gotoTxt = self:getGo("gotoBtn/gotoTxt"):GetComponent("Text")
	self._gotoRed = self:getGo("gotoBtn/gotoRed")
end

function JiSummonerBuyView:onEnter()
	JiSummonerBuyView.super.onEnter(self)

	self._paramCfg = self:getFirstParam()

	if self._paramCfg == nil then
		printError("sr----  JiSummonerBuyView:onEnter() y运营-极召唤师    未传入参数！！")

		return
	end

	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updataSkinBuyOpen, self)

	self._noOpenStr = ""
	self._nameTxt.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._paramCfg.skinId)
	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self._paramCfg.skinId, self._sprineGo, scale, nil, true, x, y)

	GameUtil.SetActive(self._gotoRed, JiSummonerController.instance:getLeftTableRed(3))
	self:_updataSkinBuyOpen()
end

function JiSummonerBuyView:_updataSkinBuyOpen()
	local actCfg = ActivityDefineConfig.instance:getCfgById(91, 91002)

	if actCfg == nil or string.nilorempty(actCfg.startTime) then
		return
	end

	local startTime = GameUtil.string2time(actCfg.startTime)

	if startTime <= ServerTime.now() then
		self._gotoTxt.text = "前往"
		self._noOpenStr = ""
	else
		local timer = GameUtil.time2date(startTime)

		self._noOpenStr = string.format("%s.%s开启", timer.month, timer.day)
		self._gotoTxt.text = self._noOpenStr
	end
end

return JiSummonerBuyView
