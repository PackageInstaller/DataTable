-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/title/model/TitleModel.lua

module("logic.extensions.title.model.TitleModel", package.seeall)

local TitleModel = class("TitleModel", BaseModel)

function TitleModel:ctor()
	return
end

function TitleModel:onInit()
	printInfo("TitleModel:onInit")

	local dic = {}
	local cfg = TitleConfig.instance:getCfg()

	for k, v in pairs(cfg) do
		if k ~= "dataList" and not v.isHide then
			v.state = GameEnum.TitleState.NONE
			v.overdueTime = -1
			v.gainTime = 0
			dic[k] = v
		end
	end

	self._dicTitle = dic
	self._curOnTitle = nil
	self._listOwned = {}
	self._listOther = {}
	self._redKeys = {}
	self._totalRedCount = 0
end

function TitleModel:_loadLocalRed(isSucc)
	if not isSucc then
		return
	end

	print("loadlocalTitleRed")

	for titleId, _ in pairs(self._dicTitle) do
		local key = "title_" .. LoginModel.instance.userId .. "_" .. titleId
		local value = Framework.LocalStorage.Instance:GetInt(key, -1)

		self:updateRedPoint(titleId, value >= 0)
	end
end

function TitleModel:onReset()
	self:onInit()
end

function TitleModel:getOwnedTitles()
	return self._listOwned
end

function TitleModel:getOtherTitles(...)
	return self._listOther
end

function TitleModel:setCurReqSelectTitleId(id)
	self._curReqSelectTitleId = id
end

function TitleModel:setWear(id)
	if self._curOnTitle and self._curOnTitle.titleId ~= id then
		self._curOnTitle.state = GameEnum.TitleState.OWN
	end

	local info = self._dicTitle[id]

	if info then
		info.state = GameEnum.TitleState.ON
	end

	self._curOnTitle = info

	self:_onDateUpdate()
end

function TitleModel:_checkOutdate()
	if self._curOnTitle and self:isOutdate(self._curOnTitle.titleId) then
		self._curOnTitle.state = GameEnum.TitleState.OUTDATE
		self._curOnTitle = nil

		self:_onDateUpdate()
	end
end

function TitleModel:getCurTitle()
	return self._curOnTitle
end

function TitleModel:updateTitleList(list, force)
	printInfo("updateTitleList")

	for k, v in ipairs(list) do
		local info = self._dicTitle[v.titleId]

		if info ~= nil then
			info.state = checknumber(v.state)
			info.overdueTime = checknumber(v.overdueTime)
			info.gainTime = checknumber(v.gainTime)

			if info.state == GameEnum.TitleState.ON then
				self._curOnTitle = info
			end

			local isActive = (info.state == GameEnum.TitleState.ON or info.state == GameEnum.TitleState.OWN) and not self:isOutdate(v.titleId)

			if not isActive or force then
				self:updateRedPoint(v.titleId, isActive)
			end
		end
	end

	self:_onDateUpdate()
	RedPointModel.instance:updateAllRedPoint()
end

function TitleModel:updateRedPoint(titleId, isActive)
	local curIsActive = self:getRedActive(titleId)

	if curIsActive ~= isActive then
		local offset = isActive and 1 or -1

		self._redKeys[titleId] = isActive
		self._totalRedCount = checknumber(self._totalRedCount) + offset

		local key = "title_" .. LoginModel.instance.userId .. "_" .. titleId

		Framework.LocalStorage.Instance:SetInt(key, offset)
		RedPointModel.instance:updateAllRedPoint()
	end
end

function TitleModel:getRedActiveTotal()
	return self._totalRedCount > 0
end

function TitleModel:getRedActive(titleId)
	return self._redKeys[titleId] == true
end

function TitleModel:isOutdate(id)
	local info = self:getInfoById(id)

	return info.overdueTime > 0 and info.overdueTime < ServerTime.nowMs()
end

function TitleModel:_onDateUpdate()
	self:updateOwnedList()

	if self._curOnTitle then
		local d = self._curOnTitle.overdueTime - ServerTime.nowMs()

		if self._curOnTitle.overdueTime > 0 and d > 0 then
			removetimer(self._checkOutdate, self)
			settimer(d * 0.001, self._checkOutdate, self)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.TitleUpdate, (self._curOnTitle or nil) and (self._curOnTitle.titleId or 0))
end

function TitleModel:isOwned(info)
	return (info.state == GameEnum.TitleState.ON or info.state == GameEnum.TitleState.OWN) and (info.overdueTime < 0 or info.overdueTime > ServerTime.nowMs())
end

function TitleModel:updateOwnedList()
	local listOwned = {}
	local listOther = {}

	for k, v in pairs(self._dicTitle) do
		if self:isOwned(v) then
			table.insert(listOwned, v)
		else
			table.insert(listOther, v)
		end
	end

	table.sort(listOwned, self._sortOwnedList)
	table.sort(listOther, self._sortOtherList)

	self._listOwned = listOwned
	self._listOther = listOther
end

function TitleModel._sortOwnedList(a, b)
	return a.gainTime > b.gainTime
end

function TitleModel._sortOtherList(a, b)
	return a.titleId > b.titleId
end

function TitleModel:getInfoById(id)
	return self._dicTitle[id]
end

function TitleModel:getCurTitleId()
	return (self._curOnTitle or nil) and (self._curOnTitle.titleId or 0)
end

TitleModel.instance = TitleModel.New()

return TitleModel
