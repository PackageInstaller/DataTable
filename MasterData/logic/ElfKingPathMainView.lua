-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/view/ElfKingPathMainView.lua

module("logic.extensions.elfkingpath.view.ElfKingPathMainView", package.seeall)

local ElfKingPathMainView = class("ElfKingPathMainView", ViewComponent)

function ElfKingPathMainView:ctor()
	ElfKingPathMainView.super.ctor(self)
end

ElfKingPathMainView.BgPicPath = {
	"copychapter/chapterbg/shuguangsenlin1",
	"copychapter/chapterbg/shuguangsenlin2",
	"copychapter/chapterbg/shuguangsenlin3"
}

function ElfKingPathMainView:unbindEvents()
	ElfKingPathMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btntips)
	self._scrollAdapter:AddOnValueChanged(self._onScrollValueChanged, self)
end

function ElfKingPathMainView:bindEvents()
	ElfKingPathMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
	GameUtil.addClickHandler(self._btntips, self._onClickTips, self)
	self._scrollAdapter:RemoveOnValueChanged()
end

function ElfKingPathMainView:buildUI()
	ElfKingPathMainView.super.buildUI(self)

	local goCellStage = self:getGo("stage/cell")
	local goTableviewStage = self:getGo("stage/tableview")

	self._tableviewStage = ScrollerList.create(goTableviewStage, goCellStage, GameUtil.handler(self._updateCellStage, self), GameUtil.handler(self._clearCellStage, self))

	local stageContent = self:getGo("stage/tableview/viewport/content")

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRight = self:getGo("btnRight")
	self._btnLeft = self:getGo("btnLeft")
	self._itemcell = self:getGo("itemcell")
	self._txtTips = self:getTxt("txtOpenTime/txt")
	self._txtNamePhase = self:getTxt("namePhase/txt")
	self._btntips = self:getGo("leftTop/btntips")
	self._dynamicBg = self:getGo("dynamicBg")
	self._nearBg1 = self:getGo("dynamicBg/nearBg1"):GetComponent(goutil.Type_UIImage)
	self._middleBg2 = self:getGo("dynamicBg/middleBg2"):GetComponent(goutil.Type_UIImage)
	self._farBg3 = self:getGo("dynamicBg/farBg3"):GetComponent(goutil.Type_UIImage)
	self._imgGos = {
		self._nearBg1.gameObject,
		self._middleBg2.gameObject,
		self._farBg3.gameObject
	}
	self._nearImageBigBG = self._nearBg1.gameObject:GetComponent("ImageBigBG")
	self._middleImageBigBG = self._middleBg2.gameObject:GetComponent("ImageBigBG")
	self._farImageBigBG = self._farBg3.gameObject:GetComponent("ImageBigBG")
	self._scrollAdapter = Framework.ScrollRectAdapter.Get(goTableviewStage.gameObject)
	self._scrollRectTransform = goTableviewStage.gameObject:GetComponent(goutil.Type_RectTransform)
	self._contentRectTransform = stageContent:GetComponent(goutil.Type_RectTransform)
	self._nearBgRectTrans = self._nearBg1:GetComponent(goutil.Type_RectTransform)
end

function ElfKingPathMainView:onExit()
	ElfKingPathMainView.super.onExit(self)
	self._tableviewStage:dispose()

	for i, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end

	self._itemScrollListDic = nil

	ElfKingPathController.instance:saveCurEnterStageId(0)
	removetimer(self._onCountdown, self)
	self:_removeDynamicBg()
end

function ElfKingPathMainView:onEnter()
	ElfKingPathMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ElfKingPathInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.OnViewOpen, self._OnViewOpen, self)
	self.addGEvent(self, GlobalNotify.OnViewClose, self._OnViewClose, self)

	self._itemScrollListDic = {}

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	ElfKingPathController.instance:getInfo()
	self:_loadDynamicBg()
	GuideController.instance:setViewVar("elf_king_path_battle", nil)
	goutil.setActive(self._dynamicBg, true)
end

function ElfKingPathMainView:_updateUIByCfg()
	self._stageCfgsByPhaseId = ElfKingPathConfig.instance:getStageCfgsGroups()
	self._hideDays = checknumber(ElfKingPathConfig.instance:getCommonValue("HIDE_DAYS"))

	local sonStageCfgs = ElfKingPathConfig.instance:getAllSonStageCfgs()
	local guideIds = {}

	for i, v in ipairs(sonStageCfgs) do
		if v.guideId and v.guideId > 0 then
			table.insert(guideIds, v.guideId)
		end

		if v.battleGuideId and v.battleGuideId > 0 then
			table.insert(guideIds, v.battleGuideId)
		end
	end

	ElfKingPathController.instance:finishGuideData(guideIds)
end

function ElfKingPathMainView:_updateUIByInfo()
	self._curPhageId = 1
	self._curPassStageId = 0
	self._curStageId = 0
	self._passAllStageTimeStamp = 0

	local curInfo = ElfKingPathModel.instance:getCurInfo()

	if curInfo then
		if not curInfo.stageInfos then
			local stageInfos = {}

			for i, v in ipairs(stageInfos) do
				local sonStageCfgs = ElfKingPathConfig.instance:getSonStageCfgsByStageId(v.stageId)

				if v.maxPassSonStageId >= #sonStageCfgs then
					self._curPassStageId = math.max(self._curPassStageId, v.stageId)
				end
			end

			self._passAllStageTimeStamp = checknumber(curInfo.passAllStageTimeStamp) / 1000
		end
	end

	self._curStageId = self._curPassStageId + 1
	self._txtTips.text = "全部试炼通关后，试炼大门将关闭"

	if self._curPassStageId >= ElfKingPathConfig.instance:getMaxStageId() then
		self._curStageId = self._curPassStageId

		self:updateTimeText()
	end

	self._curPhageId = 1

	local stageCfg = ElfKingPathConfig.instance:getStageCfg(self._curStageId)

	if stageCfg then
		self._curPhageId = stageCfg.PhaseId
	end

	self._curPassPhaseId = 1

	local passStageCfg = ElfKingPathConfig.instance:getStageCfg(self._curPassStageId)

	if passStageCfg then
		self._curPassPhaseId = passStageCfg.PhaseId
	end

	self:_switchCurPage()

	local curEnterStageId = ElfKingPathController.instance:getCurEnterStageId()

	if curEnterStageId and curEnterStageId > 0 then
		if ElfKingPathController.instance:isCurStageFirstPass() then
			UIStateManager.instance:push(ViewName.ElfKingPathPrizeView, curEnterStageId)
		else
			UIStateManager.instance:push(ViewName.ElfKingPathStageView, curEnterStageId)
		end

		ElfKingPathController.instance:saveCurEnterStageId(0)
		ElfKingPathController.instance:resetIsCurStageAllPass()
	end
end

function ElfKingPathMainView:_switchCurPage()
	goutil.setActive(self._btnLeft, self._curPhageId > 1)
	goutil.setActive(self._btnRight, self._curPhageId < #self._stageCfgsByPhaseId)

	local moveCellIndex = 0

	if self._curPhageId < self._curPassPhaseId then
		moveCellIndex = #self._stageCfgsByPhaseId[self._curPhageId] - 1
	elseif self._curPhageId > self._curPassPhaseId then
		moveCellIndex = 0
	end

	do
		local cfgs = self._stageCfgsByPhaseId[self._curPhageId]

		for i, v in pairs(cfgs) do
			if v.stageId == self._curPassStageId then
				moveCellIndex = i - 1

				break
			end
		end
	end

	self._tableviewStage:reloadData(self._stageCfgsByPhaseId[self._curPhageId] or {})
	self._tableviewStage:MoveCellToBegin(moveCellIndex)
end

function ElfKingPathMainView:_onClickLeft()
	self._curPhageId = math.max(1, self._curPhageId - 1)

	self:_switchCurPage()
end

function ElfKingPathMainView:_onClickRight()
	self._curPhageId = math.min(#self._stageCfgsByPhaseId, self._curPhageId + 1)

	self:_switchCurPage()
end

function ElfKingPathMainView:_updateCellStage(view, cell, data)
	local go = cell.gameObject
	local com = goutil.findChild(go, "com")
	local btnEnter = goutil.findChild(go, "com/btnEnter")
	local iconShow = goutil.findChild(go, "com/btnEnter/icon")
	local txtStageName = goutil.findChildTextComponent(go, "com/stageName/txt")
	local markPass = goutil.findChild(go, "com/pass")
	local markNotOpen = goutil.findChild(go, "com/notOpen")
	local select = goutil.findChild(go, "com/select")
	local stageCfg = data

	txtStageName.text = stageCfg.stageName

	goutil.setActive(select, self._curStageId == stageCfg.stageId)
	goutil.setActive(markPass, self._curPassStageId >= stageCfg.stageId)

	local isOpen = stageCfg.stageId <= self._curStageId

	goutil.setActive(markNotOpen, not isOpen)
	GameUtil.addClickHandler(btnEnter, function()
		self:onClickClg(stageCfg)
	end, self)

	if not stageCfg.pos then
		GameUtil.setAnchoredPos(com, stageCfg.pos[1], stageCfg.pos[2])

		local picPath = GameUrl.getBigbgFolderUrl("elfkingpath", stageCfg.iconPath)

		uGuiUtil.setSpriteToImage(iconShow.gameObject, uGuiUtil.SpriteType.BigBg, picPath)

		local lineLeft = goutil.findChild(go, "com/lineLeft")
		local lineRight = goutil.findChild(go, "com/lineRight")
		local isShow = stageCfg.stageId % 2 == 0

		goutil.setActive(lineLeft, isShow)
		goutil.setActive(lineRight, isShow)

		if isShow then
			go.transform:SetAsFirstSibling()
		end

		if stageCfg.stageId == ElfKingPathConfig.instance:getMaxStageId() then
			goutil.setActive(lineRight, false)
		elseif stageCfg.stageId == 1 then
			goutil.setActive(lineLeft, false)
		end

		local itemListGo = goutil.findChild(go, "com/prize/Scrollerview")

		if itemListGo and self._itemcell then
			if not self._itemScrollListDic[go] then
				local prizeScrollList = ScrollerList.create(itemListGo, self._itemcell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

				self._itemScrollListDic[go] = self._itemScrollListDic[go]

				if not stageCfg.prize then
					local prizes = ""
					local prizeStrArr = string.split(prizes, "#")

					self._itemScrollListDic[go]:reloadData(prizeStrArr)
					self._itemScrollListDic[go]:setCenterMode(true)
				end
			end
		end
	end
end

function ElfKingPathMainView:_clearCellStage(cell)
	local go = cell.gameObject
	local btnEnter = goutil.findChild(go, "com/btnEnter")
	local iconShow = goutil.findChild(go, "com/btnEnter/icon")

	uGuiUtil.clearImage(iconShow)
	GameUtil.rmClickHandler(btnEnter)

	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function ElfKingPathMainView:onClickClg(data)
	local isOpen = data.stageId <= self._curStageId

	if not isOpen then
		TipsFacade.instance:openCommonTips("关卡未解锁,请先通关前置关卡")

		return
	end

	UIStateManager.instance:push(ViewName.ElfKingPathStageView, data.stageId)
end

function ElfKingPathMainView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function ElfKingPathMainView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function ElfKingPathMainView:updateTimeText()
	self._txtTips.text = "全部试炼通关后，试炼大门将关闭"

	if self._passAllStageTimeStamp <= 0 then
		return
	end

	removetimer(self._onCountdown, self)

	self._startTime, self._endTime = GameUtil.getTimestampOnStartAndEnd(self._passAllStageTimeStamp, 1, self._hideDays)

	if self._endTime <= ServerTime.now() then
		self._txtTips.text = "全部试炼通关后，试炼大门已关闭"

		self:close()
	else
		settimer(1, self._onCountdown, self, true)
	end
end

function ElfKingPathMainView:_onCountdown()
	if self._endTime <= ServerTime.now() then
		self._txtTips.text = "全部试炼通关后，试炼大门已关闭"

		removetimer(self._onCountdown, self)
		self:close()
	else
		local leftTime = self._endTime - ServerTime.now()
		local timeStr = GameUtil.FormatTimeSymbol(leftTime)

		self._txtTips.text = string.format("距离关闭还剩余：%s", timeStr)
	end
end

function ElfKingPathMainView:_onClickTips()
	local key = ElfKingPathConfig.instance:getCommonValue("RULE_KEY")

	TipsFacade.instance:openRulesView(key)
end

function ElfKingPathMainView:_loadDynamicBg()
	local picPaths = ElfKingPathMainView.BgPicPath

	for i, v in ipairs(self._imgGos) do
		if not picPaths[i] then
			local picPath = ""

			if not string.nilorempty(picPath) then
				local url = string.format("ui/bigbg/%s.png", picPath)
				local imgGo = self._imgGos[i]

				uGuiUtil.setSpriteToImage(imgGo, uGuiUtil.SpriteType.BigBg, url)
			end
		end
	end

	self._nearBgMat1 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._middleBgMat2 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._nearBg1.material = self._nearBgMat1
	self._middleBg2.material = self._middleBgMat2

	self._nearImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
	self._middleImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
end

function ElfKingPathMainView:_removeDynamicBg()
	for k, v in pairs(self._imgGos) do
		uGuiUtil.clearImage(v)
	end

	self._nearBg1.material = nil
	self._middleBg2.material = nil

	goutil.destroy(self._nearBgMat1)
	goutil.destroy(self._middleBgMat2)

	self._nearBgMat1 = nil
	self._middleBgMat2 = nil
end

function ElfKingPathMainView:_onScrollValueChanged(vec2)
	if not self._nearBgMat1 or not self._middleBgMat2 then
		return
	end

	if goutil.getWidth(self._contentRectTransform) < goutil.getWidth(self._scrollRectTransform) then
		self._nearBgMat1:SetTextureOffset("_MainTex", Vector2.zero)
		self._middleBgMat2:SetTextureOffset("_MainTex", Vector2.zero)
	else
		self._nearBgWidth = goutil.getWidth(self._nearBgRectTrans)

		local percentPos = self._contentRectTransform.anchoredPosition.x / self._nearBgWidth

		percentPos = -1 * percentPos
		vec2.x = percentPos
		vec2.y = 0

		self._nearBgMat1:SetTextureOffset("_MainTex", vec2)
		self._middleBgMat2:SetTextureOffset("_MainTex", vec2 * 0.8)
	end
end

function ElfKingPathMainView:_OnViewOpen(view)
	if view.viewName == ViewName.PetDisplay then
		goutil.setActive(self._dynamicBg, false)
	end
end

function ElfKingPathMainView:_OnViewClose(view)
	if view.viewName == ViewName.PetDisplay then
		goutil.setActive(self._dynamicBg, true)
	end
end

return ElfKingPathMainView
