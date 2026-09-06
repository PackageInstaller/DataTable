-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/SclevelsView.lua

module("logic.extensions.scenariocopy.view.SclevelsView", package.seeall)

local SclevelsView = class("SclevelsView", ViewComponent)

function SclevelsView:ctor()
	SclevelsView.super.ctor(self)
end

function SclevelsView:buildUI()
	SclevelsView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getGo("txtTitle"):GetComponent(goutil.Type_UIText)

	local parentDir = ""

	self._parentScrollVIew = self:getGo("scrollList"):GetComponent("ScrollRect")
	self._tableview = self:getGo(parentDir .. "scrollList"):GetComponent("UITableview")
	self._scrollView = self:getGo(parentDir .. "scrollList"):GetComponent("ScrollRect")
	self._tableCell = self:getGo(parentDir .. "scrollList/item")

	self._tableCell:SetActive(false)

	self._goldBarCon = self:getGo("goldBarCon")
	self._bg2 = self:getGo("bg2")
	self._btnPre = self:getBtn("btnPre")
	self._btnNext = self:getBtn("btnNext")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtTime = self:getTxt("time/txt")
	self._nearBg1 = self:getGo("dynamicBg/nearBg1"):GetComponent(goutil.Type_UIImage)
	self._middleBg2 = self:getGo("dynamicBg/middleBg2"):GetComponent(goutil.Type_UIImage)
	self._farBg3 = self:getGo("dynamicBg/farBg3"):GetComponent(goutil.Type_UIImage)
	self._nearImageBigBG = self._nearBg1.gameObject:GetComponent("ImageBigBG")
	self._middleImageBigBG = self._middleBg2.gameObject:GetComponent("ImageBigBG")
	self._scrollAdapter = Framework.ScrollRectAdapter.Get(self._tableview.gameObject)
	self._scrollRectTransform = self._tableview.gameObject:GetComponent(goutil.Type_RectTransform)
	self._contentRectTransform = self:getGo("scrollList/viewport/content"):GetComponent(goutil.Type_RectTransform)

	local nearBgRectTrans = self:getGo("dynamicBg/nearBg1"):GetComponent(goutil.Type_RectTransform)

	self._nearBgWidth = goutil.getWidth(nearBgRectTrans)
end

function SclevelsView:bindEvents()
	SclevelsView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnPre:AddClickListener(self._onClickPre, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._scrollAdapter:AddOnValueChanged(self._onScrollValueChanged, self)
end

function SclevelsView:unbindEvents()
	SclevelsView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnPre:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._scrollAdapter:RemoveOnValueChanged()
end

function SclevelsView:destroyUI()
	SclevelsView.super.destroyUI(self)
end

function SclevelsView:onEnter()
	SclevelsView.super.onEnter(self)

	self._isFirstLoadData = true

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.ScenariocopyStageUpdate, self._refreshCompleteChapter, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	self:_initMaterial()
	self:_refreshCompleteChapter()
	self:_loadDynamicBg()

	local actId = ScenariocopyModel.instance:getActivityId()
	local scCfg = ScenariocopyConfig.instance:getActCfg(actId)
	local mat = scCfg.energy
	local list = {
		{
			showAdd = true,
			id = mat,
			showAddCallBack = function()
				EnergyController.instance:openBuyView(string.splitToNumber(mat, ":")[2])
			end
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)

	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.OperationPlot, actId)
	local curStamp = ServerTime.now()
	local diff = GameUtil.string2time(actCfg.endTime) - curStamp
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(diff)
	local endStr = langPara("%s天%d小时%d分", day, hour, min)
	local matCfg = MaterialMgr.getMatCfgByStr(mat)

	self._txtTime.text = langPara("%s将于%s后过期", matCfg.name, endStr)
end

function SclevelsView:onEnterFinished()
	SclevelsView.super.onEnterFinished(self)
end

function SclevelsView:onExit()
	SclevelsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ScenariocopyStageUpdate, self._refreshCompleteChapter, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	uGuiUtil.clearImage(self._bg)
end

function SclevelsView:onExitFinished()
	SclevelsView.super.onExitFinished(self)
end

function SclevelsView:_onClickClose()
	self:close()
end

function SclevelsView:_onReloadFinish()
	if self._isFirstLoadData then
		self._isFirstLoadData = nil

		local mainList = {}

		if self._chapterCfgs then
			for i, vCfg in pairs(self._chapterCfgs) do
				if vCfg.chapterType == ScenariocopyModel.CHAPTER_TYPE_PLOT then
					table.insert(mainList, vCfg)
				end
			end

			table.sort(mainList, function(a, b)
				return a.chapterId < b.chapterId
			end)

			local curStage = 0

			for i, v in ipairs(mainList) do
				if ScenariocopyModel.instance:getStagePass(v.chapterId, 1) then
					curStage = curStage + 1
				else
					break
				end
			end

			if curStage and curStage >= 2 and curStage <= self:_numInView() then
				self._parentScrollVIew.horizontalNormalizedPosition = curStage / checknumber(self:_numInView())
			end
		end
	end
end

function SclevelsView:_numInView()
	return #self._curViewDatas
end

function SclevelsView:_cellSize()
	return 202, 432
end

function SclevelsView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	cell.index = index

	self:_updateCell(view, cell, data)

	return cell
end

function SclevelsView:_updateCell(view, cell, data)
	local idx = cell.index + 1
	local component = SclevelItem.AddOnce(cell.gameObject)

	component:init(idx, data, self)
end

function SclevelsView:_clearTableview(cell)
	local component = SclevelItem.AddOnce(cell.gameObject)

	component:reset()
end

function SclevelsView:_updateScrollList()
	self._curViewDatas = {}

	local mainList = ScenariocopyController.instance:getChapterList(self._storyId, ScenariocopyModel.CHAPTER_TYPE_PLOT)

	table.sort(mainList, function(a, b)
		return a.chapterId < b.chapterId
	end)

	local cfgInOrder = {}

	for i, vCfg in ipairs(mainList) do
		local single = {}

		single.mainCfg = mainList[i]
		single.isLast = i == #mainList

		table.insert(cfgInOrder, single)
	end

	self._curViewDatas = cfgInOrder

	if mainList[#mainList] then
		self._lastChapterId = mainList[#mainList].chapterId
	end

	self._tableview:ReloadData()
end

function SclevelsView:_refreshCompleteChapter()
	self._planId = ScenariocopyModel.instance:getPlotId()
	self._storyId = ScenariocopyModel.instance:getTypeId()
	self._storyCfg = ScenariocopyConfig.instance:getStoryCfg(self._planId, self._storyId)
	self._chapterCfgs = ScenariocopyConfig.instance:getChapterCfgs(self._storyId)

	if self._storyCfg and self._chapterCfgs then
		self:_setTxtTitle()
		self:_updateScrollList()
	end
end

function SclevelsView:_setTxtTitle()
	self._txtTitle.text = self._storyCfg.storyName
end

function SclevelsView:_loadDynamicBg()
	if not self._storyCfg then
		return
	end

	local nearBgName = self._storyCfg.nearBg
	local middleBgName = self._storyCfg.middleBg
	local farBgName = self._storyCfg.farBg

	uGuiUtil.setSpriteToImage(self._nearBg1.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getScenarioCopyBigBgUrl(nearBgName))
	uGuiUtil.setSpriteToImage(self._middleBg2.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getScenarioCopyBigBgUrl(middleBgName))
	uGuiUtil.setSpriteToImage(self._farBg3.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getScenarioCopyBigBgUrl(farBgName))
end

function SclevelsView:_initMaterial()
	self._nearBgMat1 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._middleBgMat2 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._nearBg1.material = self._nearBgMat1
	self._middleBg2.material = self._middleBgMat2

	self._nearImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
	self._middleImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
end

function SclevelsView:_onScrollValueChanged(vec2)
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

function SclevelsView:dailyRefresh()
	if not ScenariocopyModel.instance:refreshActIdandPlotId() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))
	end
end

return SclevelsView
