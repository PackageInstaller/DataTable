-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityCollectWordsChooseDlg.lua

local ResItem = require("ClientData/ResItem")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local strClassName = "ActivityCollectWordsChooseDlg"
local ActivityCollectWordsChooseDlg = Class(strClassName, UIControls.Window)

function ActivityCollectWordsChooseDlg:ctor()
	self:initUI()
end

function ActivityCollectWordsChooseDlg:initUI()
	self.imgWordIcon = UIControls.Image(self, "BgPanel/WordPanel/Icon")
	self.textNum = UIControls.Label(self, "BgPanel/WordPanel/TextNum")
	self.btnRecover = UIControls.Button(self, "BgPanel/BtnRecover")

	self.btnRecover:addEventClick(self.onBtnRecoverClick)
end

function ActivityCollectWordsChooseDlg:setData(actObj, index)
	self.actObj = actObj
	self.actData = actObj.actData
	self.wordsBag = actObj.actData.wordsBag
	self.wordId = self.wordsBag[index].id
	self.wordPos = index

	local itemData = ResItem[self.wordId]

	if itemData and itemData.sourceIconPath and itemData.sourceIcon then
		self.imgWordIcon:setImage(itemData.sourceIconPath, itemData.sourceIcon)
	end

	self:refreshUI()
end

function ActivityCollectWordsChooseDlg:refreshUI()
	self.wordsBag = self.actObj.actData.wordsBag

	self.textNum:setText(self.wordsBag[self.wordPos].num)
end

function ActivityCollectWordsChooseDlg:onBtnRecoverClick()
	if self.wordsBag[self.wordPos].num > 0 then
		local function yesFun()
			CurAvatar:activityRPC(Functor(RPC.opActCollectWordsDestroyWord, self.actObj.opId, 1, self.wordId), self.actObj.opId)
		end

		local msgContent = utils.format(ResClientConfirm[1067].content, ResItem[self.wordId].name)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, nil, msgContent, Slot(yesFun, self), nil, -1)
	else
		MsgManager.clientNotice(644)
	end
end

function ActivityCollectWordsChooseDlg:updateActivityData()
	self:refreshUI()
end

return ActivityCollectWordsChooseDlg
