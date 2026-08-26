-- chunkname: @modules/logic/reddot/model/RedDotModel.lua

module("modules.logic.reddot.model.RedDotModel", package.seeall)

local RedDotModel = class("RedDotModel", BaseModel)

function RedDotModel:onInit()
	self._dotInfos = {}
	self._dotTree = {}
	self._latestExpireTime = 0
end

function RedDotModel:reInit()
	self._dotInfos = {}
	self._dotTree = {}
end

function RedDotModel:_setDotTree()
	local co = RedDotConfig.instance:getRedDotsCO()

	for _, v in pairs(co) do
		local parentIds = string.splitToNumber(v.parent, "#")

		for _, p in pairs(parentIds) do
			self._dotTree[p] = self._dotTree[p] or {}

			if not tabletool.indexOf(self._dotTree[p], v.id) then
				table.insert(self._dotTree[p], v.id)
			end
		end
	end
end

function RedDotModel:setRedDotInfo(info)
	self:_setDotTree()

	local socialDotInfo = SocialMessageModel.instance:getMessageUnreadRedDotGroup()

	table.insert(info, socialDotInfo)

	self._latestExpireTime = 0

	for _, v in ipairs(info) do
		local groupMo = RedDotGroupMo.New()

		groupMo:init(v)

		self._dotInfos[tonumber(v.defineId)] = groupMo
	end

	RedDotController.instance:dispatchEvent(RedDotEvent.PreSetRedDot, self._dotInfos)
	self:_recountLastestExpireTime()
end

function RedDotModel:updateRedDotInfo(info)
	for _, v in ipairs(info) do
		if not self._dotInfos[tonumber(v.defineId)] then
			local groupMo = RedDotGroupMo.New()

			groupMo:init(v)

			self._dotInfos[tonumber(v.defineId)] = groupMo
		else
			self._dotInfos[tonumber(v.defineId)]:_resetDotInfo(v)
		end
	end

	self:_recountLastestExpireTime()
end

function RedDotModel:_recountLastestExpireTime()
	self._latestExpireTime = 0

	for _, v in pairs(self._dotInfos) do
		for _, y in pairs(v.infos) do
			if y.time > 0 and y.time > ServerTime.now() then
				if self._latestExpireTime > 0 then
					if self._latestExpireTime > y.time then
						self._latestExpireTime = y.time or self._latestExpireTime
					end
				else
					self._latestExpireTime = y.time
				end
			end
		end
	end
end

function RedDotModel:getLatestExpireTime()
	return self._latestExpireTime
end

function RedDotModel:getRedDotInfo(id)
	return self._dotInfos[id]
end

function RedDotModel:_getAssociateRedDots(id)
	local dots = {}

	table.insert(dots, id)

	local function getAssociateDots(dotid)
		local parentIds = self:getDotParents(dotid)

		for _, v in pairs(parentIds) do
			table.insert(dots, v)
			getAssociateDots(v)
		end
	end

	local parentIds = self:getDotParents(id)

	if #parentIds > 0 then
		getAssociateDots(id)
	end

	return dots
end

function RedDotModel:getDotParents(id)
	local co = RedDotConfig.instance:getRedDotCO(id)

	if not co or co.parent == "" then
		return {}
	end

	return (string.splitToNumber(co.parent, "#"))
end

function RedDotModel:getDotChilds(id)
	local childs = {}

	local function getchild(id)
		if not self._dotTree[id] or #self._dotTree[id] == 0 then
			if not tabletool.indexOf(childs, id) then
				table.insert(childs, id)
			end
		else
			for _, v in pairs(self._dotTree[id]) do
				if not self._dotTree[v] or #self._dotTree[v] == 0 then
					if not tabletool.indexOf(childs, v) then
						table.insert(childs, v)
					end
				else
					getchild(v)
				end
			end
		end
	end

	getchild(id)

	return childs
end

function RedDotModel:isDotShow(id, uid)
	local isCustomShow, isShow = RedDotCustomFunc.isCustomShow(id, uid)

	if isCustomShow then
		return isShow
	end

	if not self._dotInfos[id] then
		local childs = self:getDotChilds(id)

		for _, v in pairs(childs) do
			if self._dotInfos[v] then
				for _, info in pairs(self._dotInfos[v].infos) do
					if info.value > 0 then
						return true
					end
				end
			end
		end

		return false
	elseif self._dotInfos[id].infos[uid] then
		for _, v in pairs(self._dotInfos[id].infos) do
			if v.uid == uid then
				return v.value > 0
			end
		end

		return false
	else
		if not self._dotInfos[id].infos[uid] then
			return false
		end

		return self._dotInfos[id].infos[uid].value > 0
	end

	return false
end

function RedDotModel:getDotInfo(id, uid)
	if self._dotInfos[id] then
		if self._dotInfos[id][uid] then
			return self._dotInfos[id][uid]
		else
			return self._dotInfos[id]
		end
	end

	return nil
end

function RedDotModel:getDotInfoCount(id, uid)
	if not uid or not self._dotInfos[id] or not self._dotInfos[id].infos[uid] then
		return 0
	end

	return self._dotInfos[id].infos[uid].value
end

RedDotModel.instance = RedDotModel.New()

return RedDotModel
