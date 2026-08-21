-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/personal/AirWorkShopPersonalSubViewMain.lua

module("logic.extensions.airworkshop.view.personal.AirWorkShopPersonalSubViewMain", package.seeall)

local M = class("AirWorkShopPersonalSubViewMain")

M.PosType = {
	Current = 2,
	Up = 1,
	Down = 3,
	Max = 4
}

function M:ctor(compContainer)
	self._registry = ViewElementsRegistry.New(compContainer.gameObject)
end

function M:isPageTypeMatch(pageType)
	return pageType == AirWorkShopEnum.PersonalPageType.Main
end

function M:setActive(active, pageIndex)
	self._firstActive = self._isActive == nil
	self._isActive = active

	goutil.setActive(self:getPageGo(), active)

	if active then
		self:_tryGetNewFormServer(pageIndex)
	end
end

function M:getActive()
	return self._isActive
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self:getRegistry()

	self._goPage = registry:findUIElement("air_workshop_personal_page_view_483997043")
	self._btnPlayer = UIComponentType.ButtonAdapter(registry:findUIElement("air_workshop_personal_page_view_1308098920"))
	self._imgMaskIcon = registry:findUIElement("air_workshop_personal_page_view_1593142887", UIComponentType.Image)
	self._txtPlayerName = registry:findUIElement("air_workshop_personal_page_view_580977987", UIComponentType.Text)
	self._txtUID = registry:findUIElement("air_workshop_personal_page_view_-2023968812", UIComponentType.Text)
	self._txtLevel = registry:findUIElement("air_workshop_personal_page_view_1986307501", UIComponentType.Text)
	self._txtExp = registry:findUIElement("air_workshop_personal_page_view_2043555440", UIComponentType.Text)
	self._imgExp = registry:findUIElement("air_workshop_personal_page_view_1798804860", UIComponentType.Image)
	self._infoComps = {
		[M.PosType.Current] = {
			txtLv = registry:findUIElement("air_workshop_personal_page_view_-265616964", UIComponentType.Text),
			txtNickName = registry:findUIElement("air_workshop_personal_page_view_1738338225", UIComponentType.Text),
			txtLvState = registry:findUIElement("air_workshop_personal_page_view_566912082", UIComponentType.Text)
		},
		[M.PosType.Up] = {
			go = registry:findUIElement("air_workshop_personal_page_view_-569622313"),
			txtLv = registry:findUIElement("air_workshop_personal_page_view_-1399234659", UIComponentType.Text),
			txtNickName = registry:findUIElement("air_workshop_personal_page_view_-95290052", UIComponentType.Text)
		},
		[M.PosType.Down] = {
			go = registry:findUIElement("air_workshop_personal_page_view_-84825042"),
			txtLv = registry:findUIElement("air_workshop_personal_page_view_-366351332", UIComponentType.Text),
			txtNickName = registry:findUIElement("air_workshop_personal_page_view_-177787210", UIComponentType.Text)
		},
		[M.PosType.Max] = {
			go = registry:findUIElement("air_workshop_personal_page_view_1753889298"),
			txtLv = registry:findUIElement("air_workshop_personal_page_view_1251968338", UIComponentType.Text),
			txtNickName = registry:findUIElement("air_workshop_personal_page_view_1105046879", UIComponentType.Text)
		}
	}
	self._txtTrophyCount = registry:findUIElement("air_workshop_personal_page_view_-189333529", UIComponentType.Text)
	self._txtAchievementCount = registry:findUIElement("air_workshop_personal_page_view_463497671", UIComponentType.Text)
	self._txtGetLikedCount = registry:findUIElement("air_workshop_personal_page_view_1003724730", UIComponentType.Text)
	self._txtPlayCount = registry:findUIElement("air_workshop_personal_page_view_-406501441", UIComponentType.Text)
	self._txtRodeoCount = registry:findUIElement("air_workshop_personal_page_view_-1712707508", UIComponentType.Text)
	self._txtFreeCount = registry:findUIElement("air_workshop_personal_page_view_1470633640", UIComponentType.Text)
	self._txtFreeEndlessCount = registry:findUIElement("air_workshop_personal_page_view_-375866872", UIComponentType.Text)
	self._txtFreeEndlessMaxWinCount = registry:findUIElement("air_workshop_personal_page_view_-1101051598", UIComponentType.Text)

	local txtTitleRodeoCount = registry:findUIElement("air_workshop_personal_page_view_-516698648", UIComponentType.Text)
	local txtTitleFreeCount = registry:findUIElement("air_workshop_personal_page_view_1180088008", UIComponentType.Text)

	txtTitleRodeoCount.text = lang("tip_air_entry_rodeo_mode")
	txtTitleFreeCount.text = lang("tip_air_entry_free_mode")
end

function M:destroyUI()
	self:setHandler(nil)

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getPageGo()
	return self._goPage
end

function M:getRegistry()
	return self._registry
end

function M:refreshView(msg, pageIndex)
	local handler = self:getHandler()
	local userId = handler:getUserId()

	self._txtPlayerName.text = msg.userName
	self._txtUID.text = string.format("UID %s", userId)
	self._txtLevel.text = string.format("<size=22>Lv</size>%s", msg.createLv)

	local curLvMaxExp = self:_getCurCreateLvMaxExp(msg.createLv)

	self._txtExp.text = string.format("%s/%s", msg.createExp, curLvMaxExp)
	self._imgExp.fillAmount = msg.createExp / curLvMaxExp

	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(msg.portrait)

	if portraitCO then
		IconLoader.setSprite(self._imgMaskIcon, IconType.PlayerInfoMask, portraitCO.icon)
	end

	local currentComps = self._infoComps[M.PosType.Current]

	currentComps.txtLv.text = AirWorkShopUtil.getRodeoLvGradeNamePersonal(msg.lv)
	currentComps.txtNickName.text = AirWorkShopUtil.getRodeoLvGradeNickName(msg.lv)
	currentComps.txtLvState.text = AirWorkShopUtil.getRodeoLvStateName(msg.state)

	local minLv, maxLv = AirWorkShopConfig.instance:getRodeoLvRange()
	local hasNextLv = maxLv >= msg.lv + 1
	local hasPreLv = minLv <= msg.lv - 1

	if hasNextLv then
		self._infoComps[M.PosType.Up].txtLv.text = AirWorkShopUtil.getRodeoLvGradeNamePersonal(msg.lv + 1)
		self._infoComps[M.PosType.Up].txtNickName.text = AirWorkShopUtil.getRodeoLvGradeNickName(msg.lv + 1)
	end

	if hasPreLv then
		self._infoComps[M.PosType.Down].txtLv.text = AirWorkShopUtil.getRodeoLvGradeNamePersonal(msg.lv - 1)
		self._infoComps[M.PosType.Down].txtNickName.text = AirWorkShopUtil.getRodeoLvGradeNickName(msg.lv - 1)
	end

	goutil.setActive(self._infoComps[M.PosType.Up].go, hasNextLv)
	goutil.setActive(self._infoComps[M.PosType.Down].go, hasPreLv)

	local historyMaxRodeoLv = msg.maxLv or 0

	historyMaxRodeoLv = historyMaxRodeoLv <= minLv and minLv or historyMaxRodeoLv
	self._infoComps[M.PosType.Max].txtLv.text = AirWorkShopUtil.getRodeoLvGradeNamePersonal(historyMaxRodeoLv)
	self._infoComps[M.PosType.Max].txtNickName.text = AirWorkShopUtil.getRodeoLvGradeNickName(historyMaxRodeoLv)
	self._txtTrophyCount.text = msg.seasonCupCount or 0
	self._txtAchievementCount.text = msg.achievementCupCount or 0
	self._txtGetLikedCount.text = msg.likeCount or 0
	self._txtPlayCount.text = msg.playCount or 0
	self._txtRodeoCount.text = msg.rodeoCount or 0
	self._txtFreeCount.text = msg.freeCount or 0
	self._txtFreeEndlessCount.text = msg.endlessCount or 0
	self._txtFreeEndlessMaxWinCount.text = msg.endlessWinCount or 0
end

function M:_getCurCreateLvMaxExp(createLv)
	local maxExp = 0
	local cfg = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioLevel, createLv)

	if cfg then
		maxExp = cfg.exp
	end

	return maxExp
end

function M:_tryGetNewFormServer(pageIndex)
	local handler = self:getHandler()
	local needSend = true
	local info = handler:getFirstParam() or {}

	if self._firstActive and info.mainPageMsg then
		self:refreshView(info.mainPageMsg)

		needSend = false
	end

	if needSend then
		local userId = handler:getUserId()

		AirWorkShopAtkAgent.instance:sendGetAirPageRequest(userId)
	end
end

return M
