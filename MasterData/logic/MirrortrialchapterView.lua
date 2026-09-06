-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/view/MirrortrialchapterView.lua

module("logic.extensions.mirrortrial.view.MirrortrialchapterView", package.seeall)

local MirrortrialchapterView = class("MirrortrialchapterView", ViewComponent)

function MirrortrialchapterView:ctor()
	MirrortrialchapterView.super.ctor(self)
end

function MirrortrialchapterView:buildUI()
	MirrortrialchapterView.super.buildUI(self)

	self._goldBar = self:getGo("goldBar")
	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._goCell = self:getGo("tableCell")
	self._goTable = self:getGo("tableView")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._nearBg1 = self:getGo("dynamicBg/nearBg1"):GetComponent(goutil.Type_UIImage)
	self._middleBg2 = self:getGo("dynamicBg/middleBg2"):GetComponent(goutil.Type_UIImage)
	self._farBg3 = self:getGo("dynamicBg/farBg3"):GetComponent(goutil.Type_UIImage)
	self._nearImageBigBG = self._nearBg1.gameObject:GetComponent("ImageBigBG")
	self._middleImageBigBG = self._middleBg2.gameObject:GetComponent("ImageBigBG")
	self._scrollAdapter = Framework.ScrollRectAdapter.Get(self._goTable)
	self._scrollRectTransform = self._goTable:GetComponent(goutil.Type_RectTransform)
	self._contentRectTransform = self:getGo("tableView/viewport/content"):GetComponent(goutil.Type_RectTransform)

	local nearBgRectTrans = self:getGo("dynamicBg/nearBg1"):GetComponent(goutil.Type_RectTransform)

	self._nearBgWidth = goutil.getWidth(nearBgRectTrans)
end

function MirrortrialchapterView:bindEvents()
	MirrortrialchapterView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._scrollAdapter:AddOnValueChanged(self._onScrollValueChanged, self)
end

function MirrortrialchapterView:unbindEvents()
	MirrortrialchapterView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._scrollAdapter:RemoveOnValueChanged()
end

function MirrortrialchapterView:destroyUI()
	MirrortrialchapterView.super.destroyUI(self)
end

function MirrortrialchapterView:onEnter()
	MirrortrialchapterView.super.onEnter(self)
	self:_initMaterial()

	self._curActId = MirrorTrialModel.instance:getCurActId()
	self._curActBaseCfg = self._curActId > 0 and MirrorTrialConfig.instance:getActBaseCfgById(self._curActId)

	if self._curActBaseCfg then
		self:updateUI()

		local mat = self._curActBaseCfg.showEnergy
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

		MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, list)
	else
		self:close()
	end

	GlobalDispatcher:addListener(MirrorTrialController.DailyReset, self._dailyReset, self)
	GlobalDispatcher:addListener(MirrorTrialController.NotifyFightResult, self.updateUI, self)
end

function MirrortrialchapterView:onEnterFinished()
	MirrortrialchapterView.super.onEnterFinished(self)
end

function MirrortrialchapterView:onExit()
	MirrortrialchapterView.super.onExit(self)

	if self.loadrole then
		for k, v in pairs(self.loadrole) do
			RoleObjectPool.instance:removeRole(v)
		end

		self.loadrole = nil
	end

	self:_removeDynamicBg()
	self:_removeMaterial()
	GlobalDispatcher:removeListener(MirrorTrialController.DailyReset, self._dailyReset, self)
	GlobalDispatcher:removeListener(MirrorTrialController.NotifyFightResult, self.updateUI, self)
end

function MirrortrialchapterView:onExitFinished()
	MirrortrialchapterView.super.onExitFinished(self)
end

function MirrortrialchapterView:updateUI()
	self:_removeDynamicBg()
	self:_updateData()
	self:_setTxtTitle()
	self:_loadDynamicBg()
	self:_updateTableView()
end

function MirrortrialchapterView:_onClickClose()
	UIStateManager.instance:push(ViewName.MirrortrialmainView)
	self:close()
end

function MirrortrialchapterView:_initMaterial()
	self._nearBgMat1 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._middleBgMat2 = UnityEngine.Material.New(Framework.ShaderCache.Find("aounity/ui/ui_texoffset"))
	self._nearBg1.material = self._nearBgMat1
	self._middleBg2.material = self._middleBgMat2

	self._nearImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)
	self._middleImageBigBG:SetWrapMode(UnityEngine.TextureWrapMode.Mirror)

	self._initMat = true
end

function MirrortrialchapterView:_setTxtTitle()
	if not self._curChapterCfg then
		return
	end

	local num = self._curChapterCfg.chapterId
	local showStr1 = string.format("第%s章 ", GameUtil.getChineseNumber(num))

	self._txtTitle.text = showStr1 .. self._curChapterCfg.stageName
end

function MirrortrialchapterView:_loadDynamicBg()
	if not self._curChapterCfg then
		return
	end

	local nearBgName = self._curChapterCfg.nearBg
	local middleBgName = self._curChapterCfg.middleBg
	local farBgName = self._curChapterCfg.farBg

	uGuiUtil.setSpriteToImage(self._nearBg1.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/copychapter/chapterbg/%s.png", nearBgName))
	uGuiUtil.setSpriteToImage(self._middleBg2.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/copychapter/chapterbg/%s.png", middleBgName))
	uGuiUtil.setSpriteToImage(self._farBg3.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/copychapter/chapterbg/%s.png", farBgName))
end

function MirrortrialchapterView:_updateData()
	self._curStage = MirrorTrialModel.instance:getCurStage()
	self._curStageCfg = MirrorTrialConfig.instance:getStageCfgsById(self._curActBaseCfg.activityId, self._curStage + 1)

	if self.isAllPass then
		self:close()
	else
		self._curChapter = self._curStageCfg.chapterId
		self._curChapterCfg = MirrorTrialConfig.instance:getChapterCfgsById(self._curActBaseCfg.activityId, self._curChapter)
		self._curChapterStageCfg = MirrorTrialConfig.instance:getStageCfgsByChapterId(self._curActBaseCfg.activityId, self._curChapter)
	end
end

function MirrortrialchapterView:_updateTableView()
	local moveIndex = 1

	if self._curChapterStageCfg and self._curStageCfg and moveIndex then
		local dataList = {}

		for k, v in pairs(self._curChapterStageCfg) do
			table.insert(dataList, v)
		end

		table.sort(dataList, function(a, b)
			return a.stageId < b.stageId
		end)

		for k, v in ipairs(dataList) do
			if v.stageId == self._curStageCfg.stageId then
				moveIndex = k
			end
		end

		self._tableView:reloadData(dataList)
		self._tableView:MoveCellInView(moveIndex - 1)

		return
	end

	self:close()
end

function MirrortrialchapterView:_removeDynamicBg()
	Framework.ImageBigBG.Get(self._nearBg1.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._middleBg2.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._farBg3.gameObject):ClearImage()
end

function MirrortrialchapterView:_removeMaterial()
	self._nearBg1.material = nil
	self._middleBg2.material = nil

	goutil.destroy(self._nearBgMat1)
	goutil.destroy(self._middleBgMat2)

	self._nearBgMat1 = nil
	self._middleBgMat2 = nil
	self._initMat = false
end

function MirrortrialchapterView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.node = goutil.findChild(goCell, "node")
	cell.nodeRect = cell.node:GetComponent(goutil.Type_RectTransform)
	cell.con = goutil.findChild(cell.node, "con")
	cell.txtName = goutil.findChildTextComponent(cell.con, "txtName")
	cell.role = goutil.findChild(cell.con, "role")
	cell.markNew = goutil.findChild(cell.con, "markNew")
	cell.markPass = goutil.findChild(cell.con, "markPass")
	cell.markLock = goutil.findChild(cell.con, "markLock")
	cell.eff = goutil.findChild(cell.con, "eff")
	cell.btnClick = goutil.findChild(cell.con, "btnClick")

	GameUtil.rmClickHandler(cell.btnClick)

	cell.roleLoader = RoleObjectPool.instance:removeRole(cell.roleLoader)

	self:_removeRole(goCell)

	return cell
end

function MirrortrialchapterView:_removeRole(goCell)
	self.loadrole = self.loadrole or {}

	if cell and self.loadrole[goCell] then
		RoleObjectPool.instance:removeRole(self.loadrole[goCell])
	end
end

function MirrortrialchapterView:_showRoleModel(cell, raceId)
	self.loadrole = self.loadrole or {}

	if cell then
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

		self:_removeRole(cell.go)

		local isAuto = false
		local callback

		self.loadrole[cell.go] = RoleObjectPool.instance:addRoleToParent(self.loadrole[cell.go], cfg.faceIds, cell.role, scale, callback, isAuto, x, y)

		MirrorTrialController.instance:cachePlotChapterviewRes(self._curChapter, self.loadrole[cell.go].loader.path)
	end
end

function MirrortrialchapterView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	self:_showRoleModel(cell, data.stageCardRaceId)

	if not data.pos then
		Framework.TransformUtil.SetAnchoredPos(cell.nodeRect, data.pos[1], data.pos[2])
		goutil.setActive(cell.markLock, data.stageId > self._curStage + 1)
		goutil.setActive(cell.markNew, data.stageId == self._curStage + 1)
		goutil.setActive(cell.markPass, data.stageId < self._curStage + 1)

		cell.txtName.text = string.match(data.stageName, "(%d+-%d+)")

		GameUtil.addClickHandler(cell.btnClick, GameUtil.handler(self._onClickBtn, self, data))
	end
end

function MirrortrialchapterView:_onClickBtn(data)
	if data.stageId > self._curStage + 1 then
		TipsFacade.instance:openCommonTips("需要通关上一关卡开启")
	elseif data.stageId < self._curStage + 1 then
		TipsFacade.instance:openCommonTips("已通关")
	else
		UIStateManager.instance:push(ViewName.MirrortrialMissionView, data)
	end
end

function MirrortrialchapterView:_onScrollValueChanged(vec2)
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

function MirrortrialchapterView:_dailyReset()
	self._curActCfg = MirrorTrialModel.instance:getCurActCfg()

	if self._curActCfg then
		-- block empty
	else
		TipsFacade.instance:openCommonTips("活动已结束")
		self:close()
	end
end

return MirrortrialchapterView
