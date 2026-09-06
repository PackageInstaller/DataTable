-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenStageView.lua

module("logic.extensions.dragonawaken.view.DragonAwakenStageView", package.seeall)

local DragonAwakenStageView = class("DragonAwakenStageView", ViewComponent)

function DragonAwakenStageView:ctor()
	DragonAwakenStageView.super.ctor(self)
end

function DragonAwakenStageView:unbindEvents()
	DragonAwakenStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DragonAwakenStageView:bindEvents()
	DragonAwakenStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DragonAwakenStageView:buildUI()
	DragonAwakenStageView.super.buildUI(self)

	local tableviewGo = self:getGo("tableView")
	local cellGo = self:getGo("tableCell")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goldBar = self:getGo("goldBar")
	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._info = self:getGo("info")
	self._iconInfo = self:getGo("info/petHead/icon")
	self._txtInfo = self:getTxt("info/txt")
	self._txtTipsInfo = self:getTxt("info/txtTips")
end

function DragonAwakenStageView:onExit()
	DragonAwakenStageView.super.onExit(self)
	self._tableview:dispose()
	MaterialMgr.resetAll(self._iconInfo)
end

function DragonAwakenStageView:onEnter()
	DragonAwakenStageView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._enterPhaseId = checknumber(params[2])

	self:_updateByCfg()
	self:_updateByInfo()
end

function DragonAwakenStageView:_updateByCfg()
	self._actCfg = DragonAwakenConfig.instance:getActivityCfg(self._activityId)
	self._phaseCfg = DragonAwakenConfig.instance:getPhaseCfgById(self._activityId, self._enterPhaseId)
	self._stageCfgs = DragonAwakenConfig.instance:getStageCfgs(self._phaseCfg.stagePlan)
	self._txtTitle.text = self._phaseCfg.phaseName

	local btn_list = {
		{
			showAdd = false,
			id = self._actCfg.mainCost
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, btn_list, false)

	local petCfg = DragonAwakenConfig.instance:getSupportCfgByPhaseId(self._activityId, self._enterPhaseId)

	if petCfg then
		local skinId = checknumber(petCfg.faceId)

		if skinId <= 0 then
			skinId = petCfg.raceId
		end

		MaterialMgr.setIcon(self._iconInfo, MatType.PET_SKIN, skinId)
	end

	self._txtInfo.text = self._phaseCfg.showDesc
	self._txtTipsInfo.text = self._phaseCfg and self._phaseCfg.curPowerStr
end

function DragonAwakenStageView:_updateByInfo()
	local baseInfo = DragonAwakenModel.instance:getCurBaseInfo()

	self._curPhaseId = baseInfo.curPhaseId
	self._curStageId = baseInfo.curStageId

	local moveIndex = self._curStageId

	if self._curPhaseId > self._enterPhaseId then
		self._curStageId = #self._stageCfgs + 1
		moveIndex = #self._stageCfgs
	end

	self._tableview:reloadData(self._stageCfgs)
	self._tableview:MoveCellInView(moveIndex - 1)
end

function DragonAwakenStageView:_updateCell(view, cell, data)
	local node = goutil.findChild(cell.gameObject, "node")
	local nodeRect = node:GetComponent(goutil.Type_RectTransform)

	if not data.pos then
		GameUtil.setAnchoredPos(node, data.pos[1], data.pos[2])

		local txtName = goutil.findChildTextComponent(cell.gameObject, "node/con/txtName")
		local role = goutil.findChild(cell.gameObject, "node/con/role")
		local markNew = goutil.findChild(cell.gameObject, "node/con/markNew")
		local markPass = goutil.findChild(cell.gameObject, "node/con/markPass")
		local markLock = goutil.findChild(cell.gameObject, "node/con/markLock")
		local btnClick = goutil.findChild(cell.gameObject, "node/con/btnClick")

		txtName.text = data.stageName

		goutil.setActive(markNew, false)
		goutil.setActive(markLock, false)
		goutil.setActive(markPass, false)

		local isPass = false

		if self._curStageId == data.stageId then
			goutil.setActive(markNew, true)
		elseif self._curStageId > data.stageId then
			goutil.setActive(markPass, true)

			isPass = true
		else
			goutil.setActive(markLock, true)
		end

		self:_showRoleModel(cell.gameObject, data.showPet)
		GameUtil.rmClickHandler(btnClick)
		GameUtil.addClickHandler(btnClick, GameUtil.handler(self._onClickBtn, self, data))

		local prize = data.prize
		local prizeStrAttr = string.split(prize, "#")

		for i = 1, 2 do
			local itemCellGo = goutil.findChild(cell.gameObject, "node/con/sc/Viewport/Content/cell_" .. i)
			local itemCon = goutil.findChild(itemCellGo, "icon")
			local itemGain = goutil.findChild(itemCellGo, "gain")

			MaterialMgr.resetAll(itemCon)
			goutil.setActive(itemGain, false)
			goutil.setActive(itemCellGo, false)

			local str = prizeStrAttr[i]

			if not GameUtil.isEmptyString(str) then
				goutil.setActive(itemCellGo, true)
				goutil.setActive(itemGain, isPass)
				MaterialMgr.setCellByCfg(str, itemCon)
			end
		end
	end
end

function DragonAwakenStageView:_clearCell(cell)
	local btnClick = goutil.findChild(cell.gameObject, "node/con/btnClick")

	self:_removeRole(cell.gameObject)
	GameUtil.rmClickHandler(btnClick)

	for i = 1, 2 do
		local itemCellGo = goutil.findChild(cell.gameObject, "node/con/sc/Viewport/Content/cell_" .. i)
		local itemCon = goutil.findChild(itemCellGo, "icon")
		local itemGain = goutil.findChild(itemCellGo, "gain")

		MaterialMgr.resetAll(itemCon)
		goutil.setActive(itemGain, false)
		goutil.setActive(itemCellGo, false)
	end
end

function DragonAwakenStageView:_showRoleModel(cellGo, raceId)
	self.loadrole = self.loadrole or {}

	if cellGo then
		local cfg = CharacterConfig.instance:getPetCo(raceId)

		if not cfg then
			return
		end

		local offset = CharactorFacade.instance:getFormationModelUIPosAndScale(checknumber(cfg.faceIds))
		local x, y, scale = 0, 0, 1

		if offset then
			x = checknumber(offset[1])
			y = checknumber(offset[2])
			scale = offset[3] or 1
		end

		self:_removeRole(cellGo)

		local isAuto = false
		local role = goutil.findChild(cellGo, "node/con/role")
		local callback

		self.loadrole[cellGo] = RoleObjectPool.instance:addRoleToParent(self.loadrole[cellGo], cfg.faceIds, role, scale, callback, isAuto, x, y)

		MirrorTrialController.instance:cachePlotChapterviewRes(self._enterPhaseId, self.loadrole[cellGo].loader.path)
	end
end

function DragonAwakenStageView:_removeRole(cellGo)
	self.loadrole = self.loadrole or {}

	if cellGo and self.loadrole[cellGo] then
		RoleObjectPool.instance:removeRole(self.loadrole[cellGo])
	end
end

function DragonAwakenStageView:_onClickBtn(data)
	if self._curPhaseId > self._enterPhaseId then
		TipsFacade.instance:openCommonTips("已通关")

		return
	end

	if self._curStageId > data.stageId then
		TipsFacade.instance:openCommonTips("已通关")
	elseif self._curStageId < data.stageId then
		TipsFacade.instance:openCommonTips("请通关前面关卡")
	else
		DragonAwakenController.instance:openClgMissionView(self._activityId)
	end
end

function DragonAwakenStageView:_initDynamicBg()
	self._nearBgMat1 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._middleBgMat2 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._nearBg1.material = self._nearBgMat1
	self._middleBg2.material = self._middleBgMat2

	self._nearImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
	self._middleImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)

	self._initMat = true

	local nearBgPath = "ui/bigbg/copychapter/chapterbg/pinminku1.png"
	local middleBgPath = "ui/bigbg/copychapter/chapterbg/pinminku2.png"
	local farBgPath = "ui/bigbg/copychapter/chapterbg/pinminku3.png"

	uGuiUtil.setSpriteToImage(self._nearBg1.gameObject, uGuiUtil.SpriteType.BigBg, nearBgPath)
	uGuiUtil.setSpriteToImage(self._middleBg2.gameObject, uGuiUtil.SpriteType.BigBg, middleBgPath)
	uGuiUtil.setSpriteToImage(self._farBg3.gameObject, uGuiUtil.SpriteType.BigBg, farBgPath)
end

function DragonAwakenStageView:_resetDynamicBg()
	Framework.ImageBigBG.Get(self._nearBg1.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._middleBg2.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._farBg3.gameObject):ClearImage()

	self._nearBg1.material = nil
	self._middleBg2.material = nil

	goutil.destroy(self._nearBgMat1)
	goutil.destroy(self._middleBgMat2)

	self._nearBgMat1 = nil
	self._middleBgMat2 = nil
	self._initMat = false
end

function DragonAwakenStageView:_onScrollValueChanged(vec2)
	if not self._initMat then
		return
	end

	if goutil.getWidth(self._contentRectTransform) < goutil.getWidth(self._scrollRectTransform) then
		self._nearBgMat1:SetTextureOffset("_MainTex", Vector2.zero)
		self._middleBgMat2:SetTextureOffset("_MainTex", Vector2.zero)
	else
		local percentPos = self._contentRectTransform.anchoredPosition.x / self._nearBgWidth

		percentPos = -1 * percentPos
		vec2.x = percentPos
		vec2.y = 0

		self._nearBgMat1:SetTextureOffset("_MainTex", vec2)
		self._middleBgMat2:SetTextureOffset("_MainTex", vec2 * 0.8)
	end
end

return DragonAwakenStageView
