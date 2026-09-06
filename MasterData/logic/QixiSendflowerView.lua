-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/romanticgifts/view/QixiSendflowerView.lua

module("logic.extensions.romanticgifts.view.QixiSendflowerView", package.seeall)

local QixiSendflowerView = class("QixiSendflowerView", SendflowerView)

function QixiSendflowerView:onEnter()
	self._selectData = nil

	self:_selectFlower()

	self._headInfo = self:getFirstParam()
	self._targetUserId = self._headInfo.userId

	if checkint(self._targetUserId) == 0 then
		TipsFacade.instance:openCommonTips("该用户不存在")
		self:close()
	end

	self._curActId = RomanticGiftsModel.instance:getActId()
	self._actCfg = RomanticGiftsConfig.instance:getCfgById(self._curActId)

	self._tableview:reloadData(RomanticGiftsModel.instance:getFlowerCfg())
	goutil.setActive(self._btnFinishEff.gameObject, false)
	GlobalDispatcher:addListener(GlobalNotify.QiXiSendGiftSendReq, self._updateTab, self)
end

function QixiSendflowerView:onExit()
	QixiSendflowerView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.QiXiSendGiftSendReq, self._updateTab, self)
end

function QixiSendflowerView:_onClickCell(data)
	self:_selectFlower(data)
	self._tableview:reloadData(RomanticGiftsModel.instance:getFlowerCfg())
end

function QixiSendflowerView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell

	GameUtil.rmClickHandler(cell.go)

	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtHaveCount = goutil.findChildTextComponent(cell.go, "txtHaveCount")
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)

	cell.mark = goutil.findChild(cell.go, "mark")
	cell.txtCharm = goutil.findChildTextComponent(cell.go, "txtCharm")
	cell.txtCharm.text = langPara("情义值：1")
	cell.txtSweet = goutil.findChildTextComponent(cell.go, "txtSweet")
	cell.txtSweet.text = langPara("友爱值：1")
	cell.tag = goutil.findChild(cell.go, "tag")

	GameUtil.rmClickHandler(cell.tag)

	return cell
end

function QixiSendflowerView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local matStr = data.itemKey

	MaterialMgr.setCellByCfg(matStr, cell.item)

	local matType, id, matNum = MaterialMgr.getMatParams(matStr)
	local curOwnNum = MaterialMgr.getMatCount(matStr)
	local curMax = math.floor(curOwnNum / matNum)

	if not self._selectData and curMax > 0 then
		self:_selectFlower(data)
	end

	cell.txtName.text = MaterialMgr.getMaterialsName(matType, id)
	cell.txtHaveCount.text = langPara("已拥有：%s", curOwnNum)
	cell.txtCharm.text = langPara("友爱值：%s", data.romance)
	cell.txtSweet.text = langPara("情义值：%s", data.sugar)

	goutil.setActive(cell.mark, self._selectData == data)
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickCell, self, data))
	GameUtil.addClickHandler(cell.tag, GameUtil.handler(self._onClickTag, self, data))
end

function QixiSendflowerView:_onClickTag(data)
	MaterialMgr.openGetSourceByStr(data.itemKey)
end

function QixiSendflowerView:_selectFlower(data)
	if data then
		local str = data.itemKey

		if not GameUtil.isEmptyString(str) then
			self._selectData = data

			local matType, id, matNum = MaterialMgr.getMatParams(str)

			self._curOwnValue = MaterialMgr.getMatCount(str)
			self._curMaxValue = self._curOwnValue
			self._txtRemain.text = langPara("剩余：%s", self._curMaxValue)

			self:_chargeNum(1)
		end
	else
		self._selectData = nil
		self._curOwnValue = 0
		self._curMaxValue = 0
		self._txtRemain.text = langPara("剩余：%s", 0)

		self:_chargeNum(1)
	end
end

function QixiSendflowerView:_onClickSure()
	if checkint(self._targetUserId) == 0 then
		TipsFacade.instance:openCommonTips("赠花对象不存在")
		self:close()

		return
	end

	if not self._selectData then
		TipsFacade.instance:openCommonTips("未选中赠花")

		return
	end

	if self._curNum == 0 then
		TipsFacade.instance:openCommonTips("赠花数目不可为0")

		return
	end

	local flowerCfg = RomanticGiftsModel.instance:getFlowerCfg(self._selectData.id)

	TipsFacade.instance:openCommonTips(langPara("增加了%s，%s点友爱值,自身增加%s点情义值", self._headInfo.userName, flowerCfg.romance * self._curNum, flowerCfg.sugar * self._curNum))
	QiXiSendGiftAgent.instance:sendPM_QiXiSendGiftSendReq(self._curActId, self._selectData.id, self._curNum, self._targetUserId)
	self:_playEff(flowerCfg.effPath)
end

function QixiSendflowerView:_updateTab()
	self._tableview:reloadData(RomanticGiftsModel.instance:getFlowerCfg())
end

return QixiSendflowerView
