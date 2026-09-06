-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/MaterialChallengeView.lua

module("logic.extensions.materialchallenge.view.MaterialChallengeView", package.seeall)

local MaterialChallengeView = class("MaterialChallengeView", ViewComponent)
local STAR_GOD_CHALLENGE = 3

function MaterialChallengeView:buildUI()
	MaterialChallengeView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getGo("txtTitle"):GetComponent(goutil.Type_UIText)
	self._tableview = self:getGo("scrollList"):GetComponent("UITableview")
	self._tableCell = self:getGo("scrollList/item")
	self._tableCellExt = self:getGo("scrollList/itemext")

	self._tableCell:SetActive(false)
	self._tableCellExt:SetActive(false)

	self._clipRectTrans = self:getGo("scrollList"):GetComponent(goutil.Type_RectTransform)
	self._doubleRewardTip = self:getGo("doubleRewardTip")

	self._doubleRewardTip:SetActive(false)

	self._tip = self:getGo("doubleRewardTip/tip")
	self._btnExplainCustomInput = UICustomInput.Get(self:getGo("doubleRewardTip/btnExplain"))
	self._txtTime = self:getTxt("doubleRewardTip/bg/txtTime")
	self._txtDesc = self:getTxt("doubleRewardTip/bg/txt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._vipPrivilege = self:getGo("vipPrivilege")
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
	self._txtDoubleLeftTime = goutil.findChildTextComponent(self.mainGO, "doubleRewardTip/bg/txtDoubleLeftTime")
end

function MaterialChallengeView:bindEvents()
	MaterialChallengeView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnExplainCustomInput:AddListener(self._onClickExplain, self)
	self._scrollAdapter:AddOnValueChanged(self._onScrollValueChanged, self)
end

function MaterialChallengeView:unbindEvents()
	MaterialChallengeView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnExplainCustomInput:RemoveListener()
	self._scrollAdapter:RemoveOnValueChanged()
end

function MaterialChallengeView:onEnter()
	self.addGEvent(self, GlobalNotify.StarGodChallengeGetInfoRes, self._onInfoRes, self)
	GlobalDispatcher:addListener(MopupModel.SweepSuccessed, self._updateActivityTipState, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_InfoRes, self._onInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_SweepsByTimesRes, self._onSweepsBack, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_SweepAutoRes, self._onSweepsBack, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_GetRewardMultiplyTimesRes, self._updateActivityTipState, self)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor)

	self._chapterId = self:getFirstParam()

	if not self._chapterId then
		return
	end

	local cfg = MaterialChallengeConfig.instance:getChapter(self._chapterId)

	if not cfg then
		printError("资源副本章节id不存在 chapterId = ", self._chapterId, type(self._chapterId))

		return
	end

	MaterialChallengeController.instance:sendMCLG_GetRewardMultiplyTimesReq()

	self._cfg = cfg

	VipPrivilegeTips.instance:attachToParent(self._vipPrivilege)

	self._isFirstLoadData = true

	self:_setupVipPrivilege(cfg)
	self:_initActivityTipState()
	self:_initChapterDetailInfo()

	self._isRecieveRequst = false

	MaterialChallengeAgent.instance:sendMCLG_InfoReq(self._chapterId)
	self:_initMaterial()
	self:_loadDynamicBg()
end

function MaterialChallengeView:onExit()
	VipPrivilegeTips.instance:detachFromParent()
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_SweepsByTimesRes, self._onSweepsBack, self)
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_SweepAutoRes, self._onSweepsBack, self)
	GlobalDispatcher:removeListener(MopupModel.SweepSuccessed, self._updateActivityTipState, self)
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_InfoRes, self._onInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_GetRewardMultiplyTimesRes, self._updateActivityTipState, self)
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:UnRegisterAllCallbacks()
	removetimer(self._updateActivityTipState, self)
	self:_removeDynamicBg()
	self:_removeMaterial()
end

function MaterialChallengeView:_onClickClose()
	self:close()
end

function MaterialChallengeView:_onReloadFinish()
	if self._isFirstLoadData then
		self._isFirstLoadData = nil

		local stageId = MaterialChallengeModel.instance:curOpenStageNum(self._chapterId)

		if stageId and stageId >= 1 then
			self._tableview:MoveCellToCebter(stageId - 1)
		end
	end
end

function MaterialChallengeView:_onInfoRes()
	self._isRecieveRequst = true

	self:_updateScrollList()

	local cfg = MaterialChallengeConfig.instance:getChapter(self._chapterId)

	self:_setupVipPrivilege(cfg)
end

function MaterialChallengeView:_onSweepsBack()
	local cfg = MaterialChallengeConfig.instance:getChapter(self._chapterId)

	self:_setupVipPrivilege(cfg)
end

function MaterialChallengeView:_numInView()
	return #self._curViewDatas
end

function MaterialChallengeView:_cellSize(view, index)
	if index == 0 then
		return 80, 0
	end

	return 202, 432
end

function MaterialChallengeView:_cellAtIndex(view, index)
	local isStarGod = index + 1 == #self._curViewDatas and self:_isChallengeTower()
	local tag = isStarGod and 1 or 0

	if isStarGod then
		if not self._tableCellExt then
			local tablecell = self._tableCell
			local cell = view:DequeueCellByTag(tag)

			cell = cell or view:AddChild(tablecell, tag)

			local data = self._curViewDatas[index + 1]

			cell.index = index

			self:_updateCell(view, cell, data, tag)

			return cell
		end
	end
end

function MaterialChallengeView:_updateCell(view, cell, data, tag)
	if tag == 0 then
		local component = MaterialStageItem.AddOnce(cell.gameObject)

		component:init(cell.index, data, self)
	else
		local component = GameUtil.AddLuaOnce(cell.gameObject, StarGodStageItem)

		component:init(cell.index, data, self)
	end
end

function MaterialChallengeView:_clearTableview(cell)
	local component = GameUtil.GetLua(cell.gameObject, MaterialStageItem)

	if component then
		component:reset()
	else
		local starGodComponent = GameUtil.GetLua(cell.gameObject, StarGodStageItem)

		if starGodComponent then
			starGodComponent:reset()
		end
	end
end

function MaterialChallengeView:_isChallengeTower()
	return self._chapterId == STAR_GOD_CHALLENGE
end

function MaterialChallengeView:_initScrollList(chapterId)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish, self)
	self._tableview:RegisterOnUpdatePositionCallback(function(self, view)
		self:_onUpdatePosition(view)
	end)

	self._curViewDatas = {}

	local stageCfgs = MaterialChallengeConfig.instance:getStages(chapterId)
	local num = MaterialChallengeModel.instance:curOpenStageNum(chapterId)
	local isChallengeTower = self:_isChallengeTower()

	self._curViewDatas[1] = {}

	for i, vCfg in ipairs(stageCfgs) do
		local index = i + 1

		self._curViewDatas[index] = {}
		self._curViewDatas[index].view = self
		self._curViewDatas[index].index = i
		self._curViewDatas[index].cfg = vCfg

		local isLock = not MaterialChallengeModel.instance:isStageUnlock(chapterId, i)

		self._curViewDatas[index].isLock = num < i or isLock

		if isChallengeTower then
			self._curViewDatas[index].isLast = false
		else
			self._curViewDatas[index].isLast = i == #stageCfgs
		end

		self._curViewDatas[index].openStageNum = num
		self._curViewDatas[index].evaluateValue = MaterialChallengeModel.instance:getStageEvaluateLevelTxt(vCfg.chapterId, vCfg.stageId)
	end

	if isChallengeTower then
		local element = {}

		element.view = self
		element.index = #self._curViewDatas + 1
		element.isChallengeTower = true
		element.isLock = not MaterialChallengeModel.instance:isAllStageScoreS(chapterId)
		element.isLast = true

		local str = GameUtil.getUCharList(self._cfg.chapterName)

		element.name = str[1] .. str[2] .. "幻境塔"

		table.insert(self._curViewDatas, element)
	end

	self._tableview:ReloadData()
end

function MaterialChallengeView:_updateScrollList()
	if self._curViewDatas then
		for i, v in ipairs(self._curViewDatas) do
			if i > 1 and not v.isChallengeTower then
				self._curViewDatas[i].evaluateValue = MaterialChallengeModel.instance:getStageEvaluateLevelTxt(v.cfg.chapterId, v.cfg.stageId)
			end

			if v.isChallengeTower then
				v.isLock = not MaterialChallengeModel.instance:isAllStageScoreS(self._chapterId)
			end
		end

		self._tableview:ReloadData()
	end
end

function MaterialChallengeView:_onUpdatePosition(tableView)
	local count = tableView:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableView:GetCellByIndex(i)

		if cell then
			cell.transform:SetSiblingIndex(cell.index)
		end
	end
end

function MaterialChallengeView:_initChapterDetailInfo()
	local cfg = MaterialChallengeConfig.instance:getChapter(self._chapterId)

	if cfg then
		self._txtTitle.text = cfg.chapterName
	end

	self:_initScrollList(self._chapterId)
end

function MaterialChallengeView:setLeftCount()
	return
end

function MaterialChallengeView:_initActivityTipState()
	goutil.setActive(self._tip, false)
	self:_updateActivityTipState()
	settimer(3, self._updateActivityTipState, self)
end

function MaterialChallengeView:_updateActivityTipState()
	local isInTime, desc, startTime, endTime = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Material, self._chapterId)
	local isOpen = isInTime

	if isOpen and not self._doubleRewardTip.activeSelf then
		self._doubleRewardTip:SetActive(true)
		self._tip:SetActive(false)

		self._txtDesc.text = desc

		local startTable = GameUtil.time2date(startTime)
		local endTable = GameUtil.time2date(endTime - 86400)

		self._txtTime.text = string.format("(%02d.%02d - %02d.%02d)", startTable.month, startTable.day, endTable.month, endTable.day)
	elseif not isOpen and self._doubleRewardTip.activeSelf then
		self._doubleRewardTip:SetActive(false)
		self._tip:SetActive(false)
	end

	if isOpen then
		self._txtDoubleLeftTime.text = MaterialChallengeModel.instance:getMaterialDoubleTimesDesc(self._chapterId)
	end
end

function MaterialChallengeView:_onClickExplain(hover)
	if hover then
		if not self._tip.activeSelf then
			self._tip:SetActive(true)
		else
			self._tip:SetActive(false)
		end
	elseif self._tip.activeSelf then
		self._tip:SetActive(false)
	end
end

function MaterialChallengeView:_setupVipPrivilege(cfg)
	local times = MaterialChallengeModel.instance:getFreeStrenghtMaxTimes(cfg.chapterId)

	VipPrivilegeTips.instance:attachToParent(self._vipPrivilege)
	VipPrivilegeTips.instance:setActive(times > 0)

	if times > 0 then
		local freeTimes = MaterialChallengeModel.instance:getFreeStrenghtTimes(cfg.chapterId) or 0
		local vipPrivilege = string.format("每天前%d次挑战不消耗体力(%d/%d)", times, math.max(0, times - freeTimes), times)

		VipPrivilegeTips.instance:setPrivilege(vipPrivilege)
	end
end

function MaterialChallengeView:_loadDynamicBg()
	if not self._cfg then
		return
	end

	local nearBgName = self._cfg.nearBg
	local middleBgName = self._cfg.middleBg
	local farBgName = self._cfg.farBg

	uGuiUtil.setSpriteToImage(self._nearBg1.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/copychapter/chapterbg/%s.png", nearBgName), function()
		if self._nearBg1 then
			self._nearBg1:SetNativeSize()
		end
	end)
	uGuiUtil.setSpriteToImage(self._middleBg2.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/copychapter/chapterbg/%s.png", middleBgName), function()
		if self._middleBg2 then
			self._middleBg2:SetNativeSize()
		end
	end)

	if not string.nilorempty(farBgName) then
		uGuiUtil.setSpriteToImage(self._farBg3.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/copychapter/chapterbg/%s.png", farBgName), function()
			if self._farBg3 then
				self._farBg3:SetNativeSize()
			end
		end)
	end
end

function MaterialChallengeView:_removeDynamicBg()
	Framework.ImageBigBG.Get(self._nearBg1.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._middleBg2.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._farBg3.gameObject):ClearImage()
end

function MaterialChallengeView:_initMaterial()
	self._nearBgMat1 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._middleBgMat2 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._nearBg1.material = self._nearBgMat1
	self._middleBg2.material = self._middleBgMat2

	self._nearImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
	self._middleImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
end

function MaterialChallengeView:_removeMaterial()
	self._nearBg1.material = nil
	self._middleBg2.material = nil

	goutil.destroy(self._nearBgMat1)
	goutil.destroy(self._middleBgMat2)

	self._nearBgMat1 = nil
	self._middleBgMat2 = nil
end

function MaterialChallengeView:_onScrollValueChanged(vec2)
	if goutil.getWidth(self._contentRectTransform) < goutil.getWidth(self._scrollRectTransform) then
		if self._nearBgMat1 then
			self._nearBgMat1:SetTextureOffset("_MainTex", Vector2.zero)
		end

		if self._middleBgMat2 then
			self._middleBgMat2:SetTextureOffset("_MainTex", Vector2.zero)
		end
	else
		local percentPos = self._contentRectTransform.anchoredPosition.x / self._nearBgWidth

		percentPos = -1 * percentPos
		vec2.x = percentPos
		vec2.y = 0

		if self._nearBgMat1 then
			self._nearBgMat1:SetTextureOffset("_MainTex", vec2)
		end

		if self._middleBgMat2 then
			self._middleBgMat2:SetTextureOffset("_MainTex", vec2 * 0.8)
		end
	end
end

return MaterialChallengeView
