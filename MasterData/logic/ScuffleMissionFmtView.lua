-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/buzhen/ScuffleMissionFmtView.lua

module("logic.extensions.scuffle.view.buzhen.ScuffleMissionFmtView", package.seeall)

local ScuffleMissionFmtView = class("ScuffleMissionFmtView", MissionFmtView)

function ScuffleMissionFmtView:ctor()
	ScuffleMissionFmtView.super.ctor(self)

	self._scuffleCellList = {}
end

function ScuffleMissionFmtView:buildUI()
	ScuffleMissionFmtView.super.buildUI(self)

	self._Nego_Seats = self:getGo("FmtRight/Nego_Seats")
	self._layerBg = self:getGo("FmtRight/layerBg")
	self._layerRole = self:getGo("FmtRight/layerRole")
	self._layerUI = self:getGo("FmtRight/layerUI")

	self:_buildUIExtension()
end

function ScuffleMissionFmtView:bindEvents()
	ScuffleMissionFmtView.super.bindEvents(self)
	self._btnTipCustomInput:AddListener(self._onClickTip, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
end

function ScuffleMissionFmtView:unbindEvents()
	ScuffleMissionFmtView.super.unbindEvents(self)
	self._btnTipCustomInput:RemoveListener()
	self._btnBuff:RemoveClickListener()
end

function ScuffleMissionFmtView:_buildUIExtension()
	self._extension = self:getGo("extension")

	local go = self:getResInstance(ScuffleMissionViewPresentor.FmtPetsPath)

	goutil.addChildToParent(go, self._extension)

	local name = "scufflefmtpets"

	go.name = name
	self._scrollRect = self:getGo(string.format("extension/%s/tableview", name)):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._petContainer = self:getGo(string.format("extension/%s/tableview/viewport/petContainer", name))
	self._petCell = self:getGo(string.format("extension/%s/petCell", name))

	self._petCell:SetActive(false)

	local prePath = "extension/" .. name .. "/"

	self._headIcon = self:getGo(string.format("extension/%s/playerInfo/headIcon", name))
	self._txtName = self:getTxt(string.format("extension/%s/playerInfo/name/txtName", name))
	self._txtArea = self:getTxt(string.format("extension/%s/playerInfo/txtArea", name))
	self._txtRank = self:getTxt(string.format("extension/%s/playerInfo/txtRank", name))
	self._levelIcon = self:getGo(string.format("extension/%s/playerInfo/grade", name))
	self._txtLeftTime = self:getTxt(string.format("extension/%s/txtLeftTime", name))
	self._waitShow = self:getGo(string.format("extension/%s/waitShow", name))
	self._txtWait = self:getTxt(string.format("extension/%s/waitShow/txtWait", name))
	self._btnTipCustomInput = UICustomInput.Get(self:getGo(prePath .. "btnTip"))
	self._tipGo = self:getGo(prePath .. "tip")
	self._txtTip = self:getTxt(prePath .. "tip/txtTip")
	self._btnBuff = self:getBtn(prePath .. "btnBuff")
	self._buffIcon = self:getGo(prePath .. "btnBuff/IconBg/Icon")
end

function ScuffleMissionFmtView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.SF_SetFormRes, self._onSetFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ScuffleClickEnterBattle, self._onClickStartBtn, self)
	GlobalDispatcher:addListener(GlobalNotify.ScuffleSelectBuff, self._onSelectBuff, self)
	self:_resetBuffIcon()
	self:_closeFormationShow()
	self:_setRightSpeedAndPower("？？？", "？？？")
	self:_setEnemyInfo()
	self:_initPetList()

	self._countdown = ScuffleModel.instance:getFormationCountDown()
	self._isCountDown = true

	self:_showTxtLeftTime(self._countdown)
	self:_endWaitShow()
	self:_updateTxtTip()
	settimer(1, self._onSecond, self)
	UIStateManager.instance:push(ViewName.ScuffleBuffView)
end

function ScuffleMissionFmtView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.SF_SetFormRes, self._onSetFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ScuffleClickEnterBattle, self._onClickStartBtn, self)
	GlobalDispatcher:removeListener(GlobalNotify.ScuffleSelectBuff, self._onSelectBuff, self)
	removetimer(self._onSecond, self)
	self:_removeCardList()
	self:_removeHeadIcon()
	self:_removeLevelIcon()
	self:_endWaitShow()
	self:_resetBuffIcon()
end

function ScuffleMissionFmtView:_onClickTip(hover)
	if hover then
		if not self._tipGo.activeSelf then
			self._tipGo:SetActive(true)
		else
			self._tipGo:SetActive(false)
		end
	elseif self._tipGo.activeSelf then
		self._tipGo:SetActive(false)
	end
end

function ScuffleMissionFmtView:_onClickBuff()
	UIStateManager.instance:push(ViewName.ScuffleBuffView)
end

function ScuffleMissionFmtView:_onSetFormRes()
	self:_showWaitTxt()
	self:_startWaitShow(self._countdown)
end

function ScuffleMissionFmtView:_onClickStartBtn()
	self._isCountDown = false

	UIStateManager.instance:popByName(ViewName.ScuffleBuffView)
end

function ScuffleMissionFmtView:_onSecond()
	if self._isCountDown then
		if self._countdown > 0 then
			self._countdown = self._countdown - 1

			self:_showTxtLeftTime(self._countdown)
		else
			self._isCountDown = false
		end
	end

	if self._isStartWaitShow then
		if self._waitCountdown > 0 then
			self._waitCountdown = self._waitCountdown - 1

			self:_showWaitLeftTime(self._waitCountdown)
		else
			self:_stopWaitShow()
		end
	end
end

function ScuffleMissionFmtView:_closeFormationShow()
	self._Btn_HeroSkill.gameObject:SetActive(false)
	goutil.setActive(self._psychicSkillGo, false)
	goutil.setActive(self._domainSkillGo, false)
	self._Nego_Seats:SetActive(false)
	self._layerBg:SetActive(false)
	self._layerRole:SetActive(false)
	self._layerUI:SetActive(false)
	goutil.setActive(self._tipGo, false)
end

function ScuffleMissionFmtView:_initPetList()
	self._scuffleCellList = {}

	local creepsIdList = ScuffleModel.instance:getEnemyAllPets()

	for index, id in ipairs(creepsIdList) do
		local go = goutil.cloneAndSetParent(self._petCell, self._petContainer.transform, "fmtCell" .. index)

		go:SetActive(true)

		local cell = GameUtil.AddLuaOnce(go, ScuffleFmtCell)

		cell:buildUI(go)
		cell:init(index, id)
		table.insert(self._scuffleCellList, cell)
	end

	self._scrollRect.verticalNormalizedPosition = 1
end

function ScuffleMissionFmtView:_removeCardList()
	for i, v in ipairs(self._scuffleCellList) do
		v:onReset()
	end

	table.clear(self._scuffleCellList)
	goutil.clearChildren(self._petContainer)
end

function ScuffleMissionFmtView:_setEnemyInfo()
	self._txtRank.text = "排名 " .. ScuffleModel.instance:getEnemyRank()
	self._txtName.text = ScuffleModel.instance:getEnemyName()
	self._txtArea.text = ScuffleModel.instance:getEnemyAreaName()

	HeadItemController.instance:setHeadCellByInfo(self._headIcon, ScuffleModel.instance:getEnemyHeadInfo())

	local cfg = ScuffleConfig.instance:getLevelCfgByScore(ScuffleModel.instance:getEnemyScore())

	if cfg then
		uGuiUtil.setSpriteToImage(self._levelIcon, uGuiUtil.SpriteType.BigBg, string.format(ScuffleModel.LevelPath, cfg.icon))
	end
end

function ScuffleMissionFmtView:_removeLevelIcon()
	local enemyLevel = Framework.ImageBigBG.Get(self._levelIcon)

	enemyLevel:ClearImage()
end

function ScuffleMissionFmtView:_removeHeadIcon()
	MaterialMgr.resetAll(self._headIcon)
end

function ScuffleMissionFmtView:_showTxtLeftTime(num)
	self._txtLeftTime.text = string.format("剩余时间：%d秒", num)
end

function ScuffleMissionFmtView:_showWaitTxt()
	self._txtLeftTime.text = "等待对方布阵"
end

function ScuffleMissionFmtView:_startWaitShow(time)
	self._isStartWaitShow = true
	self._waitCountdown = time

	self._waitShow:SetActive(true)
	self:_showWaitLeftTime(self._waitCountdown)
end

function ScuffleMissionFmtView:_stopWaitShow()
	self._isStartWaitShow = false
end

function ScuffleMissionFmtView:_endWaitShow()
	self:_stopWaitShow()
	self._waitShow:SetActive(false)
end

function ScuffleMissionFmtView:_showWaitLeftTime(second)
	self._txtWait.text = string.format("剩余<color=#ff0000>%d</color>秒", math.max(0, second))
end

function ScuffleMissionFmtView:_onSelectBuff()
	local buffId = ScuffleModel.instance:getSelectBuffId()

	printInfo("test _onSelectBuff = ", buffId)
	goutil.setActive(self._buffIcon, true)

	local cfg = ScuffleConfig.instance:getBuffCfg(checknumber(buffId))

	if cfg then
		uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))
	end
end

function ScuffleMissionFmtView:_resetBuffIcon()
	uGuiUtil.clearImage(self._buffIcon)
	goutil.setActive(self._buffIcon, false)
end

function ScuffleMissionFmtView:_updateTxtTip()
	self._txtTip.text = ScuffleController.instance:getBuffDesc(ScuffleController.instance:isExistCfgInActivityTime())
end

return ScuffleMissionFmtView
