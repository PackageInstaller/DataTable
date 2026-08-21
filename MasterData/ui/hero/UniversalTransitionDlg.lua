-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\UniversalTransitionDlg.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResItem = require("ClientData/ResItem")
local ResColor = require("ClientData/ResColor")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResVowMisc = require("ClientData/ResVowMisc")
local MathNode = Class("MathNode", UIControls.Child)

function MathNode:ctor()
	self.txtName = UIControls.Label(self, "BgGridPanel/BgTextName/TextName")
	self.btnMinus = UIControls.Button(self, "BgGridPanel/NumPanel/BtnNumMin")
	self.btnAdd = UIControls.Button(self, "BgGridPanel/NumPanel/BtnNumAdd")
	self.btnMax = UIControls.Button(self, "BgGridPanel/NumPanel/BtnNumMax")
	self.txtMax = UIControls.Label(self, "BgGridPanel/NumPanel/BtnNumMax/Text")
	self.txtNow = UIControls.Label(self, "BgGridPanel/NumPanel/InputNum/Text")
	self.rulePanel = UIControls.Panel(self, "BgTextRule")
	self.btnKeyboard = UIControls.Button(self, "BgGridPanel/NumPanel/InputNum")

	self.btnKeyboard:addEventClick(self.onClickKeyboard)
	self.btnMinus:addEventClick(self.onClickMinus)
	self.btnAdd:addEventClick(self.onClickAdd)
	self.btnMax:addEventClick(self.onClickMax)

	self.nowNum = 0
end

function MathNode:setData(itemId, needNum, idx, getMaxFunc, refreshParentFunc, keyboard)
	self.idx = idx
	self.needNum = needNum
	self.getMaxFunc = getMaxFunc
	self.refreshParentFunc = refreshParentFunc
	self.keyboard = keyboard

	local item = BaseObject.GetObject(itemId, 0)

	self.txtName:setText(item.name)

	if not self.itemNode then
		self.itemNode = UIControls.getGridChild(item, self, "BgGridPanel/GridPanel", true)

		self.itemNode:setVisible(true)
	end

	self.itemNode:setObj(item)
	self.txtMax:setText("+" .. self.needNum)
	self:refresh()
end

function MathNode:refresh()
	self.nowNum = self:getMax()

	self:refreshTxt()
end

function MathNode:refreshTxt()
	self.txtNow:setText(self.nowNum)

	local checkEnough = self.nowNum >= self.needNum

	self.rulePanel:setVisible(not checkEnough)
	self.txtNow:setFontColor(checkEnough and ResColor.GREYWHITE or ResColor.RED)
end

function MathNode:onClickMinus()
	if self.nowNum > 0 then
		self.nowNum = self.nowNum - 1

		self:refreshTxt()
		self.refreshParentFunc()
	else
		MsgManager.clientNotice(685)
	end
end

function MathNode:onClickAdd()
	local max = self:getMax()

	if max > self.nowNum then
		self.nowNum = self.nowNum + 1

		self:refreshTxt()
		self.refreshParentFunc()
	elseif self.nowNum >= self.needNum then
		MsgManager.clientNotice(147)
	else
		MsgManager.clientNotice(684)
	end
end

function MathNode:onClickMax()
	self.nowNum = self:getMax()

	self:refreshTxt()
	self.refreshParentFunc()
end

function MathNode:onClickKeyboard(sender)
	local num = 0

	self.keyboard:show(Slot(self.onNumChanged, self), self.nowNum, self:getMax(), 0)
	self.keyboard:setBottom(sender, 30)
end

function MathNode:onNumChanged(num)
	self.nowNum = num

	self:refreshTxt()
	self.refreshParentFunc()
end

function MathNode:getMax()
	local max = self.getMaxFunc(self.idx)
	local realMax = math.min(self.needNum, max)

	return realMax
end

local TranslationNode = Class("TranslationNode", UIControls.Child)

function TranslationNode:ctor()
	self.txtName = UIControls.Label(self, "UniversalPanel/BgTextName/TextName")
	self.txtNum = UIControls.Label(self, "UniversalPanel/BgTextNum/TextNum")
	self.mathNodeList = {}
end

function TranslationNode:setData(universalId, universalData, keyboard)
	self.universalId = universalId
	self.idList = universalData.idList
	self.numList = universalData.numList
	self.paramList = universalData.paramList
	self.keyboard = keyboard

	local item = BaseObject.GetObject(universalId, 0)

	if not self.itemNode then
		self.itemNode = UIControls.getGridChild(item, self, "UniversalPanel/GridPanel", true)

		self.itemNode:setVisible(true)
	end

	self.itemNode:setObj(item)
	self.txtName:setText(item.name)

	self.totalNum = CurAvatar:getItemNumById(self.universalId)

	local dataNum = #self.idList
	local nodeNum = #self.mathNodeList

	for i = 1, math.max(nodeNum, dataNum) do
		if i <= dataNum then
			local node

			if i <= nodeNum then
				node = self.mathNodeList[i]
			else
				node = MathNode(self, "TransitionPanel", "System/HeroShowRoom/TransitionCell")

				table.insert(self.mathNodeList, node)
			end

			node:setData(self.idList[i], self.numList[i], i, Slot(self.getMathNodeMaxNumByIdx, self), Slot(self.refreshTxt, self), self.keyboard)
			node:setVisible(true)
		else
			self.mathNodeList[i]:setVisible(false)
		end
	end

	self:refreshTxt()
end

function TranslationNode:refreshTxt()
	local allCostNum = self:getAllCostNum()

	self.txtNum:setText(allCostNum == 0 and string.format(Lang.get(30234), self.totalNum) or self.totalNum .. "/" .. allCostNum)
end

function TranslationNode:getAllCostNum()
	local totalNum = 0

	for _, mathNode in ipairs(self.mathNodeList) do
		totalNum = totalNum + mathNode.nowNum
	end

	return totalNum
end

function TranslationNode:getMathNodeMaxNumByIdx(idx)
	local totalNum = self.totalNum

	for index, mathNode in ipairs(self.mathNodeList) do
		if index ~= idx then
			totalNum = totalNum - mathNode.nowNum
		end
	end

	return totalNum
end

function TranslationNode:getTransitionData(list)
	for _, mathNode in ipairs(self.mathNodeList) do
		if mathNode.nowNum > 0 then
			table.insert(list, {
				data = {
					id = self.universalId,
					num = mathNode.nowNum
				},
				param = self.paramList[mathNode.idx]
			})
		end
	end
end

local UniversalTransitionDlg = Class("UniversalTransitionDlg", UIControls.Window)

function UniversalTransitionDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnClose:addEventClick(self.onBtnCloseClick)
	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.keyboard = UIControls.NumKeyboard(self, "")

	self.keyboard:setVisible(false)
	self.keyboard:setMaxNotice(ResClientNotice[147].notice)

	self.translationNodeList = {}
end

function UniversalTransitionDlg:setData(costIdList, costNumList)
	self.universalIdList, self.universalDataList = self:getUniversalItemId(costIdList, costNumList)

	local nodeNum = #self.translationNodeList
	local dataNum = #self.universalIdList

	for i = 1, math.max(nodeNum, dataNum) do
		if i <= dataNum then
			local node

			if nodeNum < i then
				node = TranslationNode(self, "BgPanel/ItemPanel", "System/HeroShowRoom/UniversalTransitionCell")

				table.insert(self.translationNodeList, node)
			else
				node = self.translationNodeList[i]
			end

			local universalId = self.universalIdList[i]
			local universalData = self.universalDataList[i]

			node:setData(universalId, universalData, self.keyboard)
			node:setVisible(true)
		else
			self.translationNodeList[i]:setVisible(false)
		end
	end
end

function UniversalTransitionDlg:getUniversalItemId(costIdList, costNumList)
	local universalIdList = {}
	local universalDataList = {}
	local costIdIdxDic = {}

	for index, value in ipairs(costIdList) do
		if not costIdIdxDic[value] then
			costIdIdxDic[value] = index
		end
	end

	local _, resVowMisc = next(ResVowMisc)
	local universalVowIdList = resVowMisc.universalVowIds

	if universalVowIdList then
		for _, universalId in ipairs(universalVowIdList) do
			local resItem = ResItem[universalId]
			local universalData

			for param, random_id in ipairs(resItem.extend_args3) do
				local resRandClient = ResRandClient[random_id]

				if not ClientUtils.IsRandomValid(random_id) or not resRandClient.show_ids or not (#resRandClient.show_ids > 0) or not resRandClient.show_nums or not (#resRandClient.show_nums > 0) or resRandClient.show_nums[1] ~= 1 then
					-- block empty
				else
					local id = resRandClient.show_ids[1]
					local costIdIdx = costIdIdxDic[id]

					if costIdIdx then
						local costNum = costNumList[costIdIdx]

						universalData = universalData or {
							idList = {},
							numList = {},
							paramList = {}
						}

						local tmpIdx = #universalData.idList + 1

						for key, value in ipairs(universalData.idList) do
							if costIdIdx < costIdIdxDic[value] then
								tmpIdx = key

								break
							end
						end

						table.insert(universalData.idList, tmpIdx, id)
						table.insert(universalData.numList, tmpIdx, costNum)
						table.insert(universalData.paramList, tmpIdx, param)
					end
				end
			end

			if universalData then
				local firstCostId = universalData.idList[1]
				local firstCostIdx = costIdIdxDic[firstCostId]
				local tmpIdx = #universalIdList + 1

				for key, value in ipairs(universalIdList) do
					local tmpFirstCostId = universalDataList[key].idList[1]
					local tmpFirstCostIdx = costIdIdxDic[tmpFirstCostId]

					if firstCostIdx < tmpFirstCostIdx then
						tmpIdx = key

						break
					end
				end

				table.insert(universalIdList, tmpIdx, universalId)
				table.insert(universalDataList, tmpIdx, universalData)
			end
		end
	end

	return universalIdList, universalDataList
end

function UniversalTransitionDlg:onBtnConfirmClick()
	local list = {}

	for index, node in ipairs(self.translationNodeList) do
		node:getTransitionData(list)
	end

	if #list > 0 then
		if not self.needIgnoreItemUse then
			self:onBtnCloseClick()
			RPC.itemUse(list)
		end
	else
		MsgManager.notice(Lang.get(30500))
	end
end

function UniversalTransitionDlg:onBtnCloseClick()
	self:setVisible(false)
end

return UniversalTransitionDlg
