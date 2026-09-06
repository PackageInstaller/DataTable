-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimengliclglevelView.lua

module("logic.extensions.mimengli.view.MimengliclglevelView", package.seeall)

local MimengliclglevelView = class("MimengliclglevelView", ViewComponent)

function MimengliclglevelView:ctor()
	MimengliclglevelView.super.ctor(self)
end

function MimengliclglevelView:unbindEvents()
	MimengliclglevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)

	for i, v in ipairs(self._buffList) do
		GameUtil.rmClickHandler(goutil.findChild(v, "btn"))
	end
end

function MimengliclglevelView:bindEvents()
	MimengliclglevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)

	for i, v in ipairs(self._buffList) do
		GameUtil.addClickHandler(goutil.findChild(v, "btn"), GameUtil.handler(self._onClickItem, self, v, i))
	end
end

function MimengliclglevelView:buildUI()
	MimengliclglevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnReset = self:getGo("btnReset")
	self._goldBarCon = self:getGo("goldBarCon")
	self._container = self:getGo("container")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._topTableview = self:getGo("topTableview")
	self._topTablecell = self:getGo("topTableview/topTablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._topScrollList = ScrollerList.create(self._topTableview, self._topTablecell, GameUtil.handler(self._updateTopCell, self), GameUtil.handler(self._clearTopCell, self))
	self._buffList = {}

	for i = 1, 4 do
		local buff = self:getGo("buff/buff_" .. i)

		table.insert(self._buffList, buff)
	end

	self._bossBuff = self:getGo("bossBuff")
	self._txtBossBuff = self:getTxt("bossBuff/ScrollView/Viewport/Content")
	self._txtPets = self:getTxt("goPets/txt")
	self._goChange = self:getGo("topTableview/goChange")
end

function MimengliclglevelView:onExit()
	MimengliclglevelView.super.onExit(self)
	self._scrollList:dispose()
	self._topScrollList:dispose()
end

function MimengliclglevelView:onEnter()
	MimengliclglevelView.super.onEnter(self)

	self._activityId = MiMengLiController.instance:getActivityId()

	local actId = checknumber(self:getFirstParam())

	if actId > 0 then
		self._activityId = actId
	end

	local cfgList = MiMengLiConfig.instance:getBuffTagCfgList(self._activityId) or {}

	self._buffIdxMap = {}

	for i, v in ipairs(cfgList) do
		local arr = string.split(v.job or "", "#")

		for j, key in ipairs(arr) do
			self._buffIdxMap[key] = v.tagType
		end
	end

	self._actCfg = MiMengLiConfig.instance:getActivityCfgById(self._activityId) or {}

	local fakeItemID = self._actCfg.fakeItemID
	local list = {
		{
			showAdd = false,
			id = MaterialMgr.createSerName(MatType.Item_Fake, fakeItemID)
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	self.addGEvent(self, GlobalNotify.MiMengLi_Clg_Info_Update, self._onRefreshUI, self)
	MiMengLiController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
	MiMengLiController.instance:tryShowChangeSet()
end

function MimengliclglevelView:_onRefreshUI()
	GameUtil.SetActive(self._bossBuff, false)

	local info = MiMengLiModel.instance:getInfo(self._activityId) or {}

	if not info.clgInfo then
		local clgInfo = {}

		self._clgInfo = clgInfo

		if not clgInfo.selectedPetHpInfo then
			if not clgInfo.tagNumInfo then
				local tagNumInfo = {}

				self._immunityTagType = clgInfo.immunityTagType or {}
				self._curPassStageId = checknumber(clgInfo.curPassStageId)
				self._txtBossBuff.text = ""

				if self._clgInfo.hasGainBossBuff then
					self._txtBossBuff.text = self._actCfg.bossBuffDesc

					if #self._immunityTagType > 0 then
						self._txtBossBuff.text = self._txtBossBuff.text .. "\n"
					end
				end

				local map = {}
				local temList = MiMengLiConfig.instance:getShopGoodsAllCfgList(self._activityId) or {}

				for k, shopList in pairs(temList) do
					for k2, v in pairs(shopList) do
						if v.goodsUsedClazz == "ImmunityTagBuff" and table.indexof(self._immunityTagType, checknumber(v.goodsUsedClazzParams)) ~= false and not map[checknumber(v.goodsUsedClazzParams)] then
							map[checknumber(v.goodsUsedClazzParams)] = true
							self._txtBossBuff.text = self._txtBossBuff.text .. v.desc .. "\n"
						end
					end
				end

				self._hpMap = {}

				local list = {}
				local activePet = 0

				for i, v in ipairs(clgInfo.selectedPetHpInfo) do
					local petMo = BagPetsController.instance:getPet(v.left)

					if petMo then
						table.insert(list, petMo)

						if v.right ~= 0 then
							activePet = activePet + 1
						end
					end

					self._hpMap[v.left] = v.right
				end

				ArraySort.sortOn(list, {
					function(a)
						if checknumber(self._hpMap[a.petId]) == 0 then
							return 0
						else
							return 1
						end
					end,
					"petId"
				}, {
					ArraySort.DESCENDING,
					ArraySort.DESCENDING
				})
				self._scrollList:reloadData(list)

				self._txtPets.text = langPara("探索阵容(%s/%s)", activePet, #list)
				self._buffMap = {}

				for i, v in ipairs(tagNumInfo) do
					self._buffMap[v.left] = v.right
				end

				self._shortNameMap = {}

				local buffList = MiMengLiConfig.instance:getBuffTagCfgList(self._activityId) or {}

				for i, v in ipairs(buffList) do
					self._shortNameMap[v.tagType] = v.shortName
				end

				self:_refreshTop()

				local stageList = MiMengLiConfig.instance:getStageCfgList(self._activityId) or {}

				self._stageList = stageList
				self._selectTopIdx = self._curPassStageId + 1

				local topCfg = stageList[self._selectTopIdx]

				if topCfg == nil then
					self._selectTopIdx = 1
					topCfg = stageList[self._selectTopIdx]
				end

				self:_showCurView(topCfg)
				self._topScrollList:reloadData(stageList)
				self._topScrollList:MoveCellToBegin(math.max(0, self._selectTopIdx - 2), false)
			end
		end
	end
end

function MimengliclglevelView:_refreshTop()
	for i, v in ipairs(self._buffList) do
		local txt = goutil.findChildTextComponent(v, "txt")
		local txtName = goutil.findChildTextComponent(v, "btn/txt")

		txtName.text = self._shortNameMap[i]

		local num = checknumber(self._buffMap[i])
		local cfg = MiMengLiConfig.instance:getCloseBuffCfgById(self._activityId, i, num) or {}

		txt.text = langPara("%s/%s", num, checknumber(cfg.tagNum))
	end
end

function MimengliclglevelView:_onClickTip()
	TipsFacade.instance:openRulesView("mimenglimainview_rule")
end

function MimengliclglevelView:_onClickReset()
	if self._curPassStageId == #self._stageList then
		TipsFacade.instance:openCommonTips("已经全部挑战通过，不能重复挑战")

		return
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), self._actCfg.resetTips, function()
		MiMengLiController.instance:sendResetChallenge(self._activityId)
		self:close()
	end)
end

function MimengliclglevelView:_showCurView(data)
	GameUtil.SetActive(self._bossBuff, false)
	GameUtil.SetActive(self._goChange, true)
	self:showTabAt(self._container)

	if data.stageClazz == "NormalFight" then
		GameUtil.SetActive(self._bossBuff, self._clgInfo.hasGainBossBuff or #self._immunityTagType > 0)
		self:showTabAt(self._container, ViewName.MimenglifightView, self._activityId, data.stageId)
	elseif data.stageClazz == "Shop" then
		GameUtil.SetActive(self._goChange, false)
		self:showTabAt(self._container, ViewName.MimenglishopView, self._activityId, data.stageId)
	elseif data.stageClazz == "BossFight" then
		GameUtil.SetActive(self._bossBuff, self._clgInfo.hasGainBossBuff or #self._immunityTagType > 0)
		self:showTabAt(self._container, ViewName.MimenglibossView, self._activityId, data.stageId)
	end
end

function MimengliclglevelView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local bloodbar = Framework.SliderAdapter.GetFrom(cell.gameObject, "bloodbar")
	local Fill = goutil.findChild(cell, "bloodbar/FillArea/Fill")

	MaterialMgr.setCellByMo(data, con)

	local img = goutil.findChild(cell, "img")
	local iconGo = goutil.findChild(cell, "img/iconGo")
	local right = checknumber(self._hpMap[data.petId])

	if right == -1 then
		bloodbar:SetValue(1)
		GameUtil.setUIImageColorIdx(Fill, 9)

		txtNum.text = "100%"
	else
		local percent = right / data._maxHp

		bloodbar:SetValue(percent)

		local level = Mathf.Clamp(math.floor(percent * 10) - 1, 0, 9)

		GameUtil.setUIImageColorIdx(Fill, level)

		txtNum.text = percent > 0 and percent < 0.01 and "1%" or math.floor(percent * 100) .. "%"
	end

	GameUtil.SetGray(con, false)

	if right == 0 then
		GameUtil.SetGray(con, true)
	end

	local key = PetSkinConfig.instance:getFirstJobKey(data:getDefineId())
	local idx = checknumber(self._buffIdxMap[key])

	GameUtil.SetActive(img, idx > 0)
	GameUtil.setUIImageSpriteIdx(iconGo, idx - 1)
end

function MimengliclglevelView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function MimengliclglevelView:_updateTopCell(view, cell, data, tag)
	local btn = goutil.findChild(cell, "btn")
	local select = goutil.findChild(cell, "select")
	local win = goutil.findChild(cell, "win")
	local right = goutil.findChild(cell, "right")
	local icon = goutil.findChild(cell, "btn/icon")
	local txt = goutil.findChildTextComponent(cell, "txt")

	GameUtil.SetActive(right, true)

	if data.stageClazz == "NormalFight" then
		GameUtil.setUIImageSpriteIdx(icon, 0)
	elseif data.stageClazz == "Shop" then
		GameUtil.setUIImageSpriteIdx(icon, 1)
	elseif data.stageClazz == "BossFight" then
		GameUtil.SetActive(right, false)
		GameUtil.setUIImageSpriteIdx(icon, 2)
	end

	txt.text = data.stageId

	GameUtil.SetActive(win, data.stageId <= self._curPassStageId)
	GameUtil.SetActive(select, self._selectTopIdx == data.stageId)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onTopCellClick, self, data))
end

function MimengliclglevelView:_clearTopCell(cell)
	return
end

function MimengliclglevelView:_onClickItem(cell, i)
	local num = checknumber(self._buffMap[i])
	local desc = ""
	local list = MiMengLiConfig.instance:getBuffCfgByTag(self._activityId, i) or {}

	if list and #list > 0 then
		local curCalNum = 0

		for i, v in ipairs(list) do
			if num >= v.tagNum then
				curCalNum = v.tagNum
			end
		end

		for k, v in ipairs(list) do
			if curCalNum == v.tagNum then
				local str = langPara("<color=#20b376>%s/%s\t%s</color>", curCalNum, v.tagNum, v.desc)

				desc = desc .. str

				if k ~= #list then
					desc = desc .. "\n"
				end
			elseif curCalNum < v.tagNum then
				local str = langPara("%s/%s\t%s", num, v.tagNum, v.desc)

				desc = desc .. str

				if k ~= #list then
					desc = desc .. "\n"
				end
			elseif k == #list then
				local str = langPara("<color=#20b376>%s/%s\t%s</color>", num, v.tagNum, v.desc)

				desc = desc .. str
			else
				local str = langPara("%s/%s\t%s", v.tagNum, v.tagNum, v.desc)

				desc = desc .. str .. "\n"
			end
		end
	end

	CommonTipsMgr.instance:showTextTips(desc, cell)
end

function MimengliclglevelView:_onTopCellClick(data)
	self._selectTopIdx = data.stageId

	local stageList = self._stageList
	local topCfg = stageList[self._selectTopIdx]

	if topCfg ~= nil then
		self:_showCurView(topCfg)
	end

	self._topScrollList:refresh()
	self._topScrollList:MoveCellToBegin(math.max(0, self._selectTopIdx - 2), true)
end

return MimengliclglevelView
