-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanshowView.lua

module("logic.extensions.divinelongyan.view.DivinelongyanshowView", package.seeall)

local DivinelongyanshowView = class("DivinelongyanshowView", ViewComponent)
local STACK_LIST = {
	ViewName.DivinelongyanlevelupView,
	ViewName.DivinelongyanpetskillView
}

function DivinelongyanshowView:ctor()
	DivinelongyanshowView.super.ctor(self)
end

function DivinelongyanshowView:unbindEvents()
	DivinelongyanshowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function DivinelongyanshowView:bindEvents()
	DivinelongyanshowView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnAdd, self.onClickBtnAdd, self)
end

function DivinelongyanshowView:buildUI()
	DivinelongyanshowView.super.buildUI(self)

	self.btnClose = self:getGo("Left/btn_close")
	self._roleGo = self:getGo("mask/role")
	self.score = self:getGo("score")
	self.txtScore = self:getTxt("score/txtScore")
	self.item = self:getGo("score/item")
	self.btnAdd = self:getGo("score/btnAdd")
	self.txt_name = self:getTxt("Middle/info/txt_name")
	self.txtPower = self:getTxt("Middle/info/txtPower")
	self.tableview = self:getGo("petList/tableview")
	self.cell = self:getGo("petList/cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._tabs = {}

	local btn

	for i = 1, 8 do
		local go = self:getGo("Left/yeqian/tab_" .. i)

		table.insert(self._tabs, go)
		self:getBtn(string.format("Left/yeqian/tab_%s", i)):AddClickListener(function()
			self:_onClickTab(i)
		end)
	end

	self._Container = self:getGo("container")
	self._goldBarCon = self:getGo("goldBarCon")
	self.tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))
end

function DivinelongyanshowView:onExit()
	DivinelongyanshowView.super.onExit(self)
	self.scrollList:dispose()
end

function DivinelongyanshowView:onEnter()
	DivinelongyanshowView.super.onEnter(self)

	local activityId = self:getFirstParam()

	self._activityId = activityId and checknumber(activityId) or DivinelongyanModel.instance:getActivityId()

	for k, v in pairs(STACK_LIST) do
		local isOpen = self:getTabIsOpen(k)
		local go = self._tabs[k]

		if go then
			local lock = goutil.findChild(go, "lock")

			GameUtil.SetActive(lock, not isOpen)
		end
	end

	self:_onClickTab(1)
	self.addGEvent(self, GlobalNotify.DivineLongYanUpgradeLevelRes, self.onRefreshUI, self)
	self.addGEvent(self, GlobalNotify.DivineLongYanUpgradeSkillRes, self.onRefreshUI, self)
	self:onRefreshUI()

	local cfg = DivinelongyanConfig.instance:getActCfg(self._activityId) or {}
	local costMp = cfg.costMp

	if not string.nilorempty(costMp) then
		local btnList = {
			{
				showAdd = true,
				id = costMp
			}
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
	end
end

function DivinelongyanshowView:onRefreshUI()
	local petMo = DivinelongyanModel.instance:getCurSuppopPetMo(self._activityId) or {}

	self:showPetView(petMo)

	local red1 = goutil.findChild(self._tabs[1], "red_point")
	local red2 = goutil.findChild(self._tabs[2], "red_point")

	GameUtil.SetActive(red1, false)
	GameUtil.SetActive(red2, false)

	self._matType, self._matId = DivinelongyanController.instance:getCostMatParams(self._activityId)

	local supportPet = DivinelongyanModel.instance:getSupportPet(self._activityId)
	local canSkillUp = false

	if supportPet then
		local hasNum = MaterialFacade.instance:getMatNumber(self._matType, self._matId)
		local nextCfg = DivinelongyanConfig.instance:getSupportPetLevelCfg(self._activityId, supportPet.level + 1)
		local isMax = not nextCfg
		local serMap = {}

		for k, v in pairs(CharacterConfig.skillTypeMap) do
			serMap[v] = k
		end

		local mo = DivinelongyanModel.instance:getCurSuppopPetMo(self._activityId)
		local list = DivinelongyanConfig.instance:getAllSkillCfgList(self._activityId)

		for i, cfgList in ipairs(list) do
			if not mo[DivinelongyanpetskillView.SKILL_TYPE_LEVEL[serMap[i]]] then
				for j, cfg in ipairs(cfgList) do
					if mo[DivinelongyanpetskillView.SKILL_TYPE_LEVEL[serMap[i]]] < cfg.skillLevel and cfg.petLevelLimit <= checknumber(mo.level) and hasNum >= cfg.cost then
						canSkillUp = true

						break
					end
				end

				if canSkillUp then
					break
				end
			end
		end

		GameUtil.SetActive(red1, (not isMax and nextCfg and hasNum >= nextCfg.cost or nil) and true)
		GameUtil.SetActive(red2, canSkillUp)
	end
end

function DivinelongyanshowView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local top = goutil.findChild(cell, "top")
	local selected = goutil.findChild(cell, "selected")

	GameUtil.addClickHandler(top, GameUtil.handler(self.clickCell, self, data))
	MaterialMgr.setCell(MatType.Pet, data.curFaceId, con)
end

function DivinelongyanshowView:clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function DivinelongyanshowView:clickCell(petMo)
	return
end

function DivinelongyanshowView:onClickBtnAdd()
	return
end

function DivinelongyanshowView:_onClickTab(idx)
	local isOpen = self:getTabIsOpen(idx, true)

	if isOpen then
		self:onShowView(idx)
	end
end

function DivinelongyanshowView:getTabIsOpen(idx, isShowTips)
	return true
end

function DivinelongyanshowView:onShowView(idx)
	local name = STACK_LIST[idx]

	if name == nil then
		FloatWordMgr.instance:show(ConstString.NotRelease)

		return
	end

	if self._tabs[idx] then
		for i = 1, #self._tabs do
			local btn = self._tabs[i]:GetComponent(goutil.Type_UIButton)

			btn.interactable = i ~= idx
		end
	end

	self.curTabIdx = idx

	self:showTabAt(self._Container, name, self._activityId)
end

function DivinelongyanshowView:showPetView(petMo)
	self.txt_name.text = petMo:getName()
	self.txtPower.text = petMo:getFightingPower()

	local skinId = petMo.curFaceId
	local loader
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._roleGo, scale, function(go)
					if go ~= nil then
						self:setAllSkeletonMask(go)
					end
				end, true, modelCfg[1], y)
			end
		end
	end
end

function DivinelongyanshowView:setAllSkeletonMask(go)
	local skeleton = goutil.findChildComponent(go, "skeleton", "SkeletonGraphic")

	if skeleton then
		self.tempMat.mainTexture = skeleton.material.mainTexture
		skeleton.material = self.tempMat
	end

	local trs = go.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)

		self:setAllSkeletonMask(child)
	end
end

return DivinelongyanshowView
