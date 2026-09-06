-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonghotsearch/view/NaiLongHotSearchReplyView.lua

module("logic.extensions.nailonghotsearch.view.NaiLongHotSearchReplyView", package.seeall)

local NaiLongHotSearchReplyView = class("NaiLongHotSearchReplyView", ViewComponent)

function NaiLongHotSearchReplyView:buildUI()
	NaiLongHotSearchReplyView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTask = self:getGo("btnTask")
	self._btnHuifu = self:getGo("btnHuifu")
	self._replyCol = self:getGo("replyCol")

	local replyScrView = self:getGo("replyCol/scrView")
	local replyScrCell1 = self:getGo("replyCol/scrCell1")
	local replyScrCell2 = self:getGo("replyCol/scrCell2")
	local replyScrCell3 = self:getGo("replyCol/scrCell3")

	self._sizeList = {}

	local replyScrCells = {
		replyScrCell1,
		replyScrCell2,
		replyScrCell3
	}

	for tag, go in ipairs(replyScrCells) do
		self._sizeList[tag] = {
			GameUtil.getWidth(go),
			GameUtil.getHeight(go)
		}
	end

	self._replyScrollerList = ScrollerList.create(replyScrView, replyScrCells, GameUtil.handler(self._updateReplyCell, self), GameUtil.handler(self._clearReplyCell, self))

	self._replyScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._replyScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
end

function NaiLongHotSearchReplyView:bindEvents()
	NaiLongHotSearchReplyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NaiLongHotSearchReplyView:unbindEvents()
	NaiLongHotSearchReplyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NaiLongHotSearchReplyView:onEnter()
	NaiLongHotSearchReplyView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._actData = NaiLongHotSearchConfig.instance:getActData(self._activityId)
	self._searchMo = NaiLongHotSearchController.instance:getNaiLongHotSearchMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_HotSearchGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HotSearchReplyRes, self._onUpdate, self)
	self:_onUpdate()
end

function NaiLongHotSearchReplyView:onExit()
	NaiLongHotSearchReplyView.super.onExit(self)
	self._replyScrollerList:dispose()
end

function NaiLongHotSearchReplyView:_onUpdate()
	local nowTime = ServerTime.now()
	local recordList = self._searchMo:getRecordList()

	self._replyInfoList = {}

	for _, v in ipairs(recordList) do
		local informationId = v.informationId
		local replyId = v.replyId
		local replyTimeStamp = Mathf.Floor(checknumber(v.replyTime) / 1000)
		local newestNpcId = 0
		local npcCfg = NaiLongHotSearchConfig.instance:getReplyNpcCfg(replyId) or {}

		for _, data in ipairs(npcCfg) do
			if nowTime >= replyTimeStamp + data.afterSec then
				newestNpcId = data.npcId
			else
				break
			end
		end

		local naiLongInfo = {}

		naiLongInfo.tag = 1
		naiLongInfo.data = v

		table.insert(self._replyInfoList, naiLongInfo)

		local myData = NaiLongHotSearchConfig.instance:getReplyPlanData(self._activityId, informationId, replyId)

		if myData then
			local myInfo = {}

			myInfo.tag = 2
			myInfo.data = myData

			table.insert(self._replyInfoList, myInfo)
		end

		for npcId = 1, newestNpcId do
			local data = NaiLongHotSearchConfig.instance:getReplyNpcData(replyId, npcId)

			if data then
				local info = {}

				info.tag = 3
				info.data = data

				table.insert(self._replyInfoList, info)
			end
		end
	end

	self._replyScrollerList:reloadData(self._replyInfoList)
end

function NaiLongHotSearchReplyView:_updateReplyCell(view, cell, info, tag)
	if tag == 1 then
		self:_updateReplyCellInNaiLong(view, cell, info, tag)
	elseif tag == 2 then
		self:_updateReplyCellInMy(view, cell, info, tag)
	elseif tag == 3 then
		self:_updateReplyCellInNpc(view, cell, info, tag)
	end
end

function NaiLongHotSearchReplyView:_updateReplyCellInNaiLong(view, cell, info, tag)
	local informationData = NaiLongHotSearchConfig.instance:getInformationData(self._activityId, info.data.informationId)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = informationData.desc
end

function NaiLongHotSearchReplyView:_updateReplyCellInMy(view, cell, info, tag)
	local data = info.data
	local mainGo = cell.gameObject
	local headCon = goutil.findChild(mainGo, "headCon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = data.context
	txtName.text = RoleModel.instance:getUserName()

	local headInfo = RoleModel.instance:getHeadInfo()

	HeadItemController.instance:setHeadCellByInfo(headCon, headInfo, false)
end

function NaiLongHotSearchReplyView:_updateReplyCellInNpc(view, cell, info, tag)
	local data = info.data
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "head/con")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	MaterialMgr.setIcon(con, MatType.Pet, data.skinId, nil, nil)

	txtDesc.text = data.context
	txtName.text = CharacterConfig.instance:getPetName(data.skinId)
end

function NaiLongHotSearchReplyView:_clearReplyCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "head/con")
	local headCon = goutil.findChild(mainGo, "headCon")

	MaterialMgr.clearIcon(con)
	HeadItemController.instance:resetHeadCell(headCon)
end

function NaiLongHotSearchReplyView:_getTagByIdx(data, idx)
	return data.tag
end

function NaiLongHotSearchReplyView:_getCellSize(view, idx)
	local info = self._replyInfoList[idx + 1]
	local tag = info.tag

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

return NaiLongHotSearchReplyView
