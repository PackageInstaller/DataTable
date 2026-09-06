-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/notice/model/NoticeModel.lua

module("logic.extensions.notice.model.NoticeModel", package.seeall)

local NoticeModel = class("NoticeModel", BaseModel)

function NoticeModel:ctor()
	NoticeModel.super.ctor(self)
	self:onReset()
end

function NoticeModel:onInit()
	self._isRequestNoticeList = false
end

function NoticeModel:onReset()
	self._noticeDic = {}
	self._noticeDic[GameEnum.NoticeType.Activity] = {}
	self._noticeDic[GameEnum.NoticeType.Game] = {}
	self._noticeDic[GameEnum.NoticeType.MainTain] = {}
	self._isRequestNoticeList = false
end

function NoticeModel:isRequesetNoticeList()
	return self._isRequestNoticeList
end

function NoticeModel:setRequestNoticeList(isRequest)
	self._isRequestNoticeList = isRequest

	return self
end

function NoticeModel:clearNoticeList()
	self._noticeDic = {}
	self._noticeDic[GameEnum.NoticeType.Activity] = {}
	self._noticeDic[GameEnum.NoticeType.Game] = {}
	self._noticeDic[GameEnum.NoticeType.MainTain] = {}
end

function NoticeModel:hasNewNotices(noticeType)
	if not self._noticeDic then
		return false
	end

	local notices = self._noticeDic[noticeType]

	if not notices then
		return false
	end

	for k, v in pairs(notices) do
		if self:isNewNotice(v) then
			return true
		end
	end

	return false
end

function NoticeModel:hasAlterNotices()
	if not self._noticeDic then
		return false
	end

	for k, v in pairs(self._noticeDic) do
		for k1, v1 in pairs(v) do
			if v1.isAlter then
				return true
			end
		end
	end

	return false
end

function NoticeModel:isNewNotice(notice)
	if notice and notice.flag == 2 then
		local isRead = UnityEngine.PlayerPrefs.GetInt("notice_read_" .. notice.id)

		return isRead == 0
	end

	return false
end

function NoticeModel:addNotice(noticeMO)
	if self._noticeDic and self._noticeDic[noticeMO.type] then
		table.insert(self._noticeDic[noticeMO.type], noticeMO)
	end
end

function NoticeModel:hasAnyData()
	for k, v in pairs(self._noticeDic) do
		if v and #v > 0 then
			return true
		end
	end

	return false
end

function NoticeModel:hasMainTain()
	return self._noticeDic and self._noticeDic[GameEnum.NoticeType.MainTain] and #self._noticeDic[GameEnum.NoticeType.MainTain] > 0
end

function NoticeModel:getNoticeListByType(type)
	return self._noticeDic[type]
end

function NoticeModel:sort()
	for k, v in pairs(self._noticeDic) do
		table.sort(v, self._sortFunc)
	end
end

function NoticeModel:markNoticeRead(data)
	UnityEngine.PlayerPrefs.SetInt("notice_read_" .. data.id, 1)
end

function NoticeModel._sortFunc(a, b)
	local isMaintain_a = a.type == GameEnum.NoticeType.MainTain
	local isMaintain_b = b.type == GameEnum.NoticeType.MainTain

	if isMaintain_a then
		return true
	end

	if isMaintain_b then
		return false
	end

	return a.order < b.order
end

NoticeModel.instance = NoticeModel.New()

return NoticeModel
