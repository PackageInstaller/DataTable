-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/ItemMergeView.lua

module("logic.extensions.material.view.ItemMergeView", package.seeall)

local ItemMergeView = class("ItemMergeView", ViewComponent)
local json = require("cjson")

function ItemMergeView:ctor()
	ItemMergeView.super.ctor(self)
end

function ItemMergeView:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._mergeBtn:AddClickListener(self._onClickMerge, self)
	self._m10Btn:AddClickListener(self._onClickM10, self)
	self._minusBtn:AddClickListener(self._onClickMinus, self)
	self._addBtn:AddClickListener(self._onClickAdd, self)
	self._a10Btn:AddClickListener(self._onClickA10, self)
	self._procNumText:AddOnValueChanged(self._onValueChanged, self)
end

function ItemMergeView:unbindEvents()
	self._closeBtn:RemoveClickListener()
	self._mergeBtn:RemoveClickListener()
	self._m10Btn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._a10Btn:RemoveClickListener()
	self._procNumText:RemoveOnValueChanged()
end

function ItemMergeView:buildUI()
	self._closeBtn = self:getBtn("BG/Close")
	self.txtTitle = self:getTxt("BG/txt_Title")
	self._m10Btn = self:getBtn("Tip/Marks/BtnM10")
	self._minusBtn = self:getBtn("Tip/Marks/BtnMs")
	self._addBtn = self:getBtn("Tip/Marks/BtnAdd")
	self._a10Btn = self:getBtn("Tip/Marks/BtnA10")
	self._procNumText = self:getInput("Tip/IptItem")
	self._mergeBtn = self:getBtn("Tip/BtnMerge")
	self._mergeTxt = self:getGo("Tip/TxtMerge"):GetComponent("Text")
	self._numTxts = {}
	self._iconImgs = {}
	self._nameTxts = {}

	for i = 1, 2 do
		self._numTxts[i] = self:getGo("Tip/IconBg" .. i .. "/TxtNum"):GetComponent("Text")
		self._iconImgs[i] = self:getGo("Tip/IconBg" .. i .. "/Icon")
		self._nameTxts[i] = self:getGo("Tip/IconBg" .. i .. "/TxtName"):GetComponent("Text")
	end
end

function ItemMergeView:destroyUI()
	return
end

function ItemMergeView:onEnter()
	self._itemDatas = {}
	self._itemDatas[1] = self._viewPresentor._openParam[1]

	local cfg = self._viewPresentor._openParam[2]

	self.txtTitle.text = lang("道具合成")

	if cfg and not string.nilorempty(cfg.title) then
		self.txtTitle.text = cfg.title
	end

	self:initMergeInfos(self._itemDatas[1].type, self._itemDatas[1].id)
	self:initTip()
	MaterialController.instance:registerLocalNotify("ItemUsed", self._onClickClose, self)
end

function ItemMergeView:initTip()
	for i = 1, 2 do
		MaterialMgr.setCell(self._itemDatas[i].type, self._itemDatas[i].id, self._iconImgs[i])

		self._nameTxts[i].text = MaterialMgr.getMaterialsName(self._itemDatas[i].type, self._itemDatas[i].id)
	end
end

function ItemMergeView:initMergeInfos(matType, id)
	self._itemDatas[2] = {}
	self._totalSourceNum = 0
	self._totalProductNum = 0
	self._sourceNum = 10
	self._maxProductNum = 10
	self._sourceNum, self._itemDatas[2].type, self._itemDatas[2].id = MaterialConfig.instance:getMergeCfgByMatAndId(matType, id)
	self._mergeTxt.text = langPara("每<color=#466887>%s</color>个 %s 可以合成1个 %s", self._sourceNum, MaterialMgr.getMaterialsName(matType, id), MaterialMgr.getMaterialsName(self._itemDatas[2].type, self._itemDatas[2].id))
	self._maxProductNum = math.floor(self._itemDatas[1].num / self._sourceNum)
	self._maxProductNum = self:dealAndshowLimitTips(self._maxProductNum)

	local max = math.floor(99999 / self._sourceNum)

	self._maxProductNum = math.min(self._maxProductNum, max)

	self._procNumText:SetText(self._maxProductNum)
	self:_refreshText()
end

function ItemMergeView:dealAndshowLimitTips(cc)
	local count = checknumber(cc)

	if self._itemDatas[2].type == MatType.Item_Badge and count > 1 then
		FloatWordMgr.instance:show(lang("单次只可合成1个徽章噢"))

		count = 1
	end

	return count
end

function ItemMergeView:onEnterFinished()
	return
end

function ItemMergeView:onExit()
	self._itemDatas = {}

	MaterialController.instance:unregisterLocalNotify("ItemUsed", self._onClickClose, self)
end

function ItemMergeView:onExitFinished()
	return
end

function ItemMergeView:_refreshText()
	local myNum = MaterialModel.instance:getMaterialsNumber(self._itemDatas[1].type, self._itemDatas[1].id)

	self._numTxts[1].text = myNum >= self._sourceNum and myNum .. "/" .. self._sourceNum or "<color=#ff0000>" .. myNum .. "/" .. self._sourceNum .. "</color>"
	self._numTxts[2].text = self._maxProductNum > 0 and self._maxProductNum or "<color=#ff0000>" .. self._maxProductNum .. "</color>"
end

function ItemMergeView:_onClickClose()
	self:close()
end

function ItemMergeView:_onClickMinus()
	self:_changeNum(self._totalProductNum - 1)
end

function ItemMergeView:_onClickAdd()
	self:_changeNum(self._totalProductNum + 1)
end

function ItemMergeView:_onClickMax()
	self:_changeNum(self._itemDatas[1].num / self._sourceNum)
end

function ItemMergeView:_onSliderChange()
	return
end

function ItemMergeView:_onValueChanged(strNum)
	local num = checknumber(strNum)

	num = self._maxProductNum > 0 and Mathf.Clamp(num, 1, self._maxProductNum) or Mathf.Clamp(num, 0, self._maxProductNum)

	self._procNumText:SetText(tostring(num))
end

function ItemMergeView:_onClickMerge()
	local num = checknumber(self._procNumText:GetText())

	if num > 0 then
		num = num * self._sourceNum

		MaterialFacade.instance:useItem(self._itemDatas[1].type, self._itemDatas[1].id, num)
	else
		local name = MaterialMgr.getMaterialsName(self._itemDatas[1].type, self._itemDatas[1].id)

		TipsFacade.instance:openCommonTips(langPara("%s数量不足，无法合成", name))
	end
end

function ItemMergeView:_onClickM10()
	self:_changeNumText(-10)
end

function ItemMergeView:_onClickMinus()
	self:_changeNumText(-1)
end

function ItemMergeView:_onClickAdd()
	self:_changeNumText(1)
end

function ItemMergeView:_onClickA10()
	self:_changeNumText(10)
end

function ItemMergeView:_changeNumText(delta)
	local num = checknumber(self._procNumText:GetText()) + delta

	self:dealAndshowLimitTips(num)

	num = self._maxProductNum > 0 and Mathf.Clamp(num, 1, self._maxProductNum) or Mathf.Clamp(num, 0, self._maxProductNum)

	self._procNumText:SetText(tostring(num))
end

return ItemMergeView
