-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkonguniontrialView.lua

module("logic.extensions.chuangkongunion.view.ChuangkonguniontrialView", package.seeall)

local ChuangkonguniontrialView = class("ChuangkonguniontrialView", ViewComponent)

function ChuangkonguniontrialView:ctor()
	ChuangkonguniontrialView.super.ctor(self)
	self:initCfg()
end

function ChuangkonguniontrialView:initCfg()
	self.breachForm = ChuangkongunionConfig.instance:getBreachFormCfg(ChuangkongunionModel.instance:getActId())
	self.breachFormOnline = {}

	for _, v in ipairs(self.breachForm) do
		table.insert(self.breachFormOnline, v)
	end

	self.breachFormStage = {}

	for _, v in ipairs(self.breachFormOnline) do
		local cfg = ChuangkongunionConfig.instance:getBreachFormStageById(v.taskId)

		table.insertto(self.breachFormStage, cfg)
	end
end

function ChuangkonguniontrialView:unbindEvents()
	self._scrollAdapter:RemoveOnValueChanged()
	ChuangkonguniontrialView.super.unbindEvents(self)
end

function ChuangkonguniontrialView:bindEvents()
	ChuangkonguniontrialView.super.bindEvents(self)
	self._scrollAdapter:AddOnValueChanged(self._onScrollValueChanged, self)
end

function ChuangkonguniontrialView:buildUI()
	ChuangkonguniontrialView.super.buildUI(self)

	self.ScrollView = self:getGo("ScrollView")
	self.Cell = self:getGo("Cell")
	self._scrollerList = ScrollerList.create(self.ScrollView, self.Cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local tabelView = self._scrollerList:getView()

	tabelView.useAnchorPosition = true

	local this = self

	tabelView:RegisterOnUpdatePositionCallback(function(self, view)
		this:_onUpdatePosition(view)
	end)

	self._nearBg1 = self:getGo("dynamicBg/nearBg1"):GetComponent(goutil.Type_UIImage)
	self._middleBg2 = self:getGo("dynamicBg/middleBg2"):GetComponent(goutil.Type_UIImage)
	self._farBg3 = self:getGo("dynamicBg/farBg3"):GetComponent(goutil.Type_UIImage)
	self._nearImageBigBG = self._nearBg1.gameObject:GetComponent("ImageBigBG")
	self._middleImageBigBG = self._middleBg2.gameObject:GetComponent("ImageBigBG")

	local nearBgRectTrans = self:getGo("dynamicBg/nearBg1"):GetComponent(goutil.Type_RectTransform)

	self._nearBgWidth = goutil.getWidth(nearBgRectTrans)
	self._scrollAdapter = Framework.ScrollRectAdapter.Get(tabelView.gameObject)
	self._scrollRectTransform = tabelView.gameObject:GetComponent(goutil.Type_RectTransform)
	self._contentRectTransform = self:getGo("ScrollView/Viewport/Content"):GetComponent(goutil.Type_RectTransform)
end

function ChuangkonguniontrialView:onExit()
	self._scrollerList:dispose()
	self:_removeDynamicBg()
	self:_removeDynamicBg()
	ChuangkongunionController.instance:unregisterNotify(ChuangkongunionController.DATA_CHANGE, self.updateUI, self)
	ChuangkonguniontrialView.super.onExit(self)
end

function ChuangkonguniontrialView:onEnter()
	ChuangkonguniontrialView.super.onEnter(self)

	self.role = {}

	self._scrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))
	self._scrollerList:reloadData(self.breachFormStage)
	ChuangkongunionController.instance:registerNotify(ChuangkongunionController.DATA_CHANGE, self.updateUI, self)
	ChuangkongunionController.instance:getTrialInfo()
	self:_initMaterial()
	self:_loadDynamicBg()
end

function ChuangkonguniontrialView:_loadDynamicBg()
	local strToFormat = "ui/bigbg/copychapter/chapterbg/%s.png"

	uGuiUtil.setSpriteToImage(self._nearBg1.gameObject, uGuiUtil.SpriteType.BigBg, string.format(strToFormat, "chuangkonglianmeng1"))
	uGuiUtil.setSpriteToImage(self._middleBg2.gameObject, uGuiUtil.SpriteType.BigBg, string.format(strToFormat, "chuangkonglianmeng2"))
	uGuiUtil.setSpriteToImage(self._farBg3.gameObject, uGuiUtil.SpriteType.BigBg, string.format(strToFormat, "chuangkonglianmeng3"))
end

function ChuangkonguniontrialView:_removeDynamicBg()
	uGuiUtil.clearImage(self._nearBg1.gameObject)
	uGuiUtil.clearImage(self._middleBg2.gameObject)
	uGuiUtil.clearImage(self._farBg3.gameObject)
end

function ChuangkonguniontrialView:_initMaterial()
	self._nearBgMat1 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._middleBgMat2 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._nearBg1.material = self._nearBgMat1
	self._middleBg2.material = self._middleBgMat2

	self._nearImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
	self._middleImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
end

function ChuangkonguniontrialView:_removeMaterial()
	self._nearBg1.material = nil
	self._middleBg2.material = nil

	goutil.destroy(self._nearBgMat1)
	goutil.destroy(self._middleBgMat2)

	self._nearBgMat1 = nil
	self._middleBgMat2 = nil
end

function ChuangkonguniontrialView:_onScrollValueChanged(vec2)
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

function ChuangkonguniontrialView:_updateCell(view, cell, data)
	local isFinishTrial = ChuangkongunionModel.instance:isFinishTrial(data.taskId, data.stage)
	local isCurTrial = ChuangkongunionModel.instance:isCurTrial(data.taskId, data.stage)
	local isOpenTrial = ChuangkongunionModel.instance:isOpenTrial(data.taskId)
	local lock = goutil.findChild(cell, "lock")
	local pass = goutil.findChild(cell, "txtPass")
	local btnClick = goutil.findChild(cell, "con/btnClick")

	GameUtil.rmClickHandler(btnClick)
	goutil.setActive(lock, false)
	goutil.setActive(pass, false)

	if isFinishTrial then
		goutil.setActive(pass, true)
	else
		GameUtil.addClickHandler(btnClick, GameUtil.handler(self._onClickCell, self, data))

		if not isCurTrial or not isOpenTrial then
			goutil.setActive(lock, true)
		end
	end

	local modelId = checknumber(data.modelId)
	local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(modelId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1
				local con = goutil.findChild(cell, "con/pet/role")

				if modelId > 0 then
					RoleObjectPool.instance:removeRole(self.role[cell])

					self.role[cell] = RoleObjectPool.instance:addRoleToParent(self.role[cell], modelId, con, scale, nil, false, modelCfg[1], y)
				end

				local name = goutil.findChildTextComponent(cell, "con/pet/txtName")

				name.text = data.title
			end
		end
	end
end

function ChuangkonguniontrialView:_onUpdatePosition(tableView)
	local count = tableView:GetVisibleCount()
	local nodePoses = {
		0,
		-94,
		7.5,
		-86.7
	}

	for i = 0, count - 1 do
		local cell = tableView:GetCellByIndex(i)

		if cell then
			local num = cell.index % #nodePoses

			num = num == 0 and #nodePoses or num

			local x, _, __ = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)

			GameUtil.setAnchoredPos(cell, x, nodePoses[num])
			cell.transform:SetSiblingIndex(cell.index)
		end
	end
end

function ChuangkonguniontrialView:_onClickCell(data)
	local isCurTrial = ChuangkongunionModel.instance:isCurTrial(data.taskId, data.stage)
	local isOpenTrial = ChuangkongunionModel.instance:isOpenTrial(data.taskId)
	local isFinishPreTrial = ChuangkongunionModel.instance:isFinishPreTrial(data.taskId)
	local cfgBreachForm = self.breachFormOnline[data.taskId]

	printWarn(cfgBreachForm.startTime)

	if GameUtil.getTimePeriodType(cfgBreachForm.startTime, cfgBreachForm.endTime) == GameUtil.beforeTimePeriod then
		local timeStart = GameUtil.string2date(cfgBreachForm.startTime, true)
		local tipStr = string.format("%d年%d月%d日开启", timeStart.year, timeStart.month, timeStart.day)

		FloatWordMgr.instance:show(tipStr)
	elseif not isFinishPreTrial then
		printWarn("请先通关上一关卡")
		FloatWordMgr.instance:show("请先通关上一关卡")
	elseif not isOpenTrial then
		local prePlotTask = cfgBreachForm.prePlotTask
		local plotCfg = ScenariocopyConfig.getChapterCfg(prePlotTask[2], prePlotTask[3])
		local tipStr = string.format("需%d通关才开启", plotCfg.chapterName)

		FloatWordMgr.instance:show(tipStr)
	elseif not isCurTrial then
		FloatWordMgr.instance:show("请先通关上一关卡")
	else
		UIStateManager.instance:open(ViewName.ChuangkongunionstageView, ChuangkongunionstageView.TYPE_TRIAL, data.taskId, data.stage)
	end
end

function ChuangkonguniontrialView:_onReloadFinish()
	local index = 0

	for _, v in ipairs(self.breachFormOnline) do
		index = index + ChuangkongunionModel.instance:curTrialStage(v.taskId)
	end

	printWarn(index)
	self._scrollerList:MoveCellToCenter(index, false)
end

function ChuangkonguniontrialView:_clearCell(cell)
	local btnClick = goutil.findChild(cell, "con/btnClick")

	GameUtil.rmClickHandler(btnClick)
	RoleObjectPool.instance:removeRole(self.role[cell])
end

function ChuangkonguniontrialView:updateUI()
	self._scrollerList:refresh()
	self:_onReloadFinish()
end

return ChuangkonguniontrialView
