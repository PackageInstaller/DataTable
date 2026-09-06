-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/publicity/PublicityMainView.lua

module("logic.extensions.publicity.PublicityMainView", package.seeall)

local PublicityMainView = class("PublicityMainView", TableViewComponent)

function PublicityMainView:ctor()
	PublicityMainView.super.ctor(self)

	self._btnItemList = nil
	self._cellItemList = nil
end

function PublicityMainView:bindEvents()
	PublicityMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		GameUtil.saveUserData("PublicityMainView_OpenTab_" .. LoginModel.instance.userId, 0)
		self:close()
	end, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "publicitymain")
	end, self)
end

function PublicityMainView:unbindEvents()
	PublicityMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
end

function PublicityMainView:onExit()
	PublicityMainView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil
end

function PublicityMainView:destroyUI()
	PublicityMainView.super.destroyUI(self)
	MaterialMgr.resetAll(self._sloganGo)
	MaterialMgr.resetAll(self._boardGo)

	for _, go in pairs(self._btnItemList or {}) do
		if go and go.itemGo then
			UnityEngine.GameObject.Destroy(go.itemGo)
		end
	end

	self._btnItemList = nil

	for _, go in pairs(self._cellItemList or {}) do
		if go and go.itemGo then
			UnityEngine.GameObject.Destroy(go.itemGo)
		end
	end

	self._cellItemList = nil
end

function PublicityMainView:buildUI()
	PublicityMainView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._itemBtnGo = self:getGo("itemBtn")
	self._btnsParentTran = self:getGo("btnsParentTran").transform
	self._cellItem = self:getGo("cellItem")
	self._cellParentTran = self:getGo("cellParentTran").transform
	self._sloganGo = self:getGo("sloganGo")
	self._boardGo = self:getGo("boardGo")

	GameUtil.SetActive(self._itemBtnGo, false)
	GameUtil.SetActive(self._cellItem, false)
end

function PublicityMainView:onEnter()
	PublicityMainView.super.onEnter(self)

	self._chosIndex = 1

	local value = GameUtil.getUserData("PublicityMainView_OpenTab_" .. LoginModel.instance.userId)

	if checknumber(value) > 0 then
		self._chosIndex = value
	end

	if checknumber(self:getFirstParam()) > 0 then
		self._chosIndex = self:getFirstParam()
	end

	self:_createLeftBtns()
	self:_onClickLeftBtn(self._chosIndex, true)

	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function PublicityMainView:_createLeftBtns()
	local allCfgs = PublicityMainConfig.instance:getAllPublicityTableCfgs()

	if allCfgs == nil or #allCfgs == 0 then
		printError("sr---减负   PublicityMainView:_createLeftBtns()   为毛没有配置？？？")

		return
	end

	self._btnItemList = self._btnItemList or {}

	for i = 1, #allCfgs do
		if self._btnItemList[i] == nil or self._btnItemList[i].itemGo == nil then
			local go = UnityEngine.GameObject.Instantiate(self._itemBtnGo, self._btnsParentTran)
			local var_10_0 = {
				itemGo = go,
				itemChg = go:GetComponent("UIImageSpriteChange"),
				itemTxt = goutil.findChildTextComponent(go, "itemTxt")
			}

			var_10_0.itemTxtChg = goutil.findChild(go, "itemTxt"):GetComponent("UITextColorChange")
			var_10_0.tagGo = goutil.findChild(go, "tagGo")
			var_10_0.tagTxt = goutil.findChildTextComponent(go, "tagGo/tagTxt")
			self._btnItemList[i] = var_10_0
		else
			GameUtil.asBtn(self._btnItemList[i].itemGo):RemoveClickListener()
		end

		GameUtil.SetActive(self._btnItemList[i].itemGo, true)
		self._btnItemList[i].itemChg:SetState(0)
		self._btnItemList[i].itemTxtChg:SetState(0)

		self._btnItemList[i].itemTxt.text = allCfgs[i].tabName

		if string.nilorempty(allCfgs[i].tag) then
			self._btnItemList[i].tagTxt.text = ""

			GameUtil.SetActive(self._btnItemList[i].tagGo, false)
		else
			GameUtil.SetActive(self._btnItemList[i].tagGo, true)

			self._btnItemList[i].tagTxt.text = allCfgs[i].tag
		end

		GameUtil.asBtn(self._btnItemList[i].itemGo):AddClickListener(function()
			self:_onClickLeftBtn(allCfgs[i].tabId)
		end, self)
	end

	if #self._btnItemList > #allCfgs then
		for i = #allCfgs + 1, #self._btnItemList do
			GameUtil.SetActive(self._btnItemList[i].itemGo, false)
		end
	end
end

function PublicityMainView:_onClickLeftBtn(index, isForce)
	if self._chosIndex == index and not isForce then
		return
	end

	local cfg = PublicityMainConfig.instance:getPublicityTableCfg(index)

	if cfg == nil then
		index = 1
		cfg = PublicityMainConfig.instance:getPublicityTableCfg(1)
	end

	if cfg == nil or checknumber(cfg.planId) <= 0 then
		printError("sr---减负  PublicityMainView:_onClickLeftBtn()  请检查！！")

		return
	end

	local path = "ui/bigbg/publicity/%s.png"

	uGuiUtil.setSpriteToImage(self._sloganGo, uGuiUtil.SpriteType.BigBg, string.format(path, cfg.sloganIcon))
	uGuiUtil.setSpriteToImage(self._boardGo, uGuiUtil.SpriteType.BigBg, string.format(path, cfg.boardIcon))

	local item = self._btnItemList[self._chosIndex]

	if item and item.itemGo then
		item.itemChg:SetState(0)
		item.itemTxtChg:SetState(0)
	end

	if self._btnItemList[index] then
		self._btnItemList[index].itemChg:SetState(1)
		self._btnItemList[index].itemTxtChg:SetState(1)
	end

	self._chosIndex = index
	self._curViewDatas = PublicityMainConfig.instance:getPublicityTaskCfgs(cfg.planId)

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		printError("sr---减负  PublicityMainView:_onClickLeftBtn()  没有任务可显示？？")

		return
	end

	if #self._curViewDatas <= 4 then
		GameUtil.SetActive(self._tableview, false)
		GameUtil.SetActive(self._cellParentTran, true)
		self:_createRightItems()
	else
		GameUtil.SetActive(self._cellParentTran, false)
		GameUtil.SetActive(self._tableview, true)
		self._tableview:ReloadData()
	end
end

function PublicityMainView:_createRightItems()
	self._cellItemList = self._cellItemList or {}

	for i = 1, #self._curViewDatas do
		if self._cellItemList[i] == nil or self._cellItemList[i].itemGo == nil then
			local go = UnityEngine.GameObject.Instantiate(self._cellItem, self._cellParentTran)

			self._cellItemList[i] = {
				itemGo = go,
				tagGo = goutil.findChild(go, "nameTxt/tagGo"),
				tagTxt = goutil.findChildTextComponent(go, "nameTxt/tagGo/tagTxt"),
				nameTxt = goutil.findChildTextComponent(go, "nameTxt"),
				descTxt = goutil.findChildTextComponent(go, "descTxt"),
				clickBtnGo = goutil.findChild(go, "clickBtn")
			}
		else
			GameUtil.asBtn(self._cellItemList[i].clickBtnGo):RemoveClickListener()
		end

		GameUtil.SetActive(self._cellItemList[i].itemGo, true)

		if string.nilorempty(self._curViewDatas[i].tag) then
			self._cellItemList[i].tagTxt.text = ""

			GameUtil.SetActive(self._cellItemList[i].tagGo, false)
		else
			GameUtil.SetActive(self._cellItemList[i].tagGo, true)

			self._cellItemList[i].tagTxt.text = self._curViewDatas[i].tag
		end

		self._cellItemList[i].nameTxt.text = self._curViewDatas[i].name
		self._cellItemList[i].descTxt.text = self._curViewDatas[i].desc

		GameUtil.asBtn(self._cellItemList[i].clickBtnGo):AddClickListener(function()
			if string.nilorempty(self._curViewDatas[i].jumpTo) then
				FloatWordMgr.instance:show("暂无可前往配置")

				return
			end

			GameUtil.saveUserData("PublicityMainView_OpenTab_" .. LoginModel.instance.userId, self._chosIndex)
			GotoMgr.gotoByString(self._curViewDatas[i].jumpTo)
		end, self)
	end

	if #self._cellItemList > #self._curViewDatas then
		for i = #self._curViewDatas + 1, #self._cellItemList do
			GameUtil.SetActive(self._cellItemList[i].itemGo, false)
		end
	end
end

function PublicityMainView:_getPath()
	return {
		cellPath = "cellItem",
		viewPath = "cellListSR"
	}
end

function PublicityMainView:_cellSize()
	return 664, 115
end

function PublicityMainView:_updateCell(view, cell, data)
	local tagGo = goutil.findChild(cell, "nameTxt/tagGo")
	local tagTxt = goutil.findChildTextComponent(cell, "nameTxt/tagGo/tagTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local clickBtnGo = goutil.findChild(cell, "clickBtn")

	GameUtil.asBtn(clickBtnGo):RemoveClickListener()

	if string.nilorempty(data.tag) then
		tagTxt.text = ""

		GameUtil.SetActive(tagGo, false)
	else
		GameUtil.SetActive(tagGo, true)

		tagTxt.text = data.tag
	end

	nameTxt.text = data.name
	descTxt.text = data.desc

	GameUtil.asBtn(clickBtnGo):AddClickListener(function()
		if string.nilorempty(data.jumpTo) then
			FloatWordMgr.instance:show("暂无可前往配置")

			return
		end

		GameUtil.saveUserData("PublicityMainView_OpenTab_" .. LoginModel.instance.userId, self._chosIndex)
		GotoMgr.gotoByString(data.jumpTo)
	end, self)
end

return PublicityMainView
