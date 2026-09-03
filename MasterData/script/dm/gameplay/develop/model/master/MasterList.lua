-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MasterList.lua

require("dm.gameplay.develop.model.master.Master")

MasterList = class("MasterList", objectlua.Object, _M)

MasterList:has("_masterList", {
	is = "r"
})
MasterList:has("_player", {
	is = "r"
})

function MasterList:initialize(player)
	super.initialize(self)

	self._masterList = {}
	self._masterLockList = {}
	self._masterNumber = 0
	self._player = player
end

function MasterList:initLockMaster(devs)
	local config = ConfigReader:getDataTable("MasterBase")

	for i, v in pairs(config) do
		local master = self._masterList[i]

		if master then
			self._masterLockList[i] = nil
		elseif not master and not self._masterLockList[i] then
			master = Master:new(i, self._player, devs)
			self._masterLockList[i] = master
		end
	end
end

function MasterList:isExistMaster(id)
	for _, v in pairs(self._masterList) do
		if v and id == v:getId() then
			return true
		end
	end

	return false
end

function MasterList:synchronize(data, devs)
	if not data then
		return
	end

	self._masterNumber = 0

	for k, v in pairs(data) do
		local master = self._masterList[k]

		if not master then
			master = Master:new(k, self._player, devs)
			self._masterList[k] = master

			self:addMaster(master)
		end

		master:synchronize(v)

		self._masterNumber = self._masterNumber + 1
	end

	self:initLockMaster(devs)
end

function MasterList:synchronizeDelEquipKernel(data)
	if not data then
		return
	end

	self._masterNumber = 0

	for k, v in pairs(data) do
		local master = self:getMasterById(k)

		if master then
			dump(v, "有这个主角，卸载身上的装备!!!!!")
			master:syncDelEquipKernelList(v)
		else
			dump(v, "没有这个主角!!!!!")
		end
	end
end

function MasterList:syncAttrEffect()
	for i, master in pairs(self._masterList) do
		master:syncAttrEffect()
	end
end

function MasterList:addMaster(master)
	if master == nil then
		return
	end

	self._masterList[tostring(master:getId())] = master

	RemoteObjectRegistry:getInstance():registerObject(tostring(master:getId()), master)
end

function MasterList:getMasterNumber()
	return self._masterNumber
end

function MasterList:getMasterByIndex(index)
	local n = 1

	for k, v in pairs(self._masterList) do
		if index == n then
			return v
		end

		n = n + 1
	end

	return nil
end

function MasterList:getMasterById(masterid)
	return self._masterList[masterid] or self._masterLockList[masterid]
end

function MasterList:getAllMaster()
	return self._masterList
end

function MasterList:clearAttrsFlag()
	for _, master in pairs(self._masterList) do
		master:clearAttrsFlag()
	end
end

function MasterList:rCreateEffects()
	for _, master in pairs(self._masterList) do
		master:removeEffect()
		master:rCreateBaseAttEffect()
		master:addEffect()
	end
end

function MasterList:getShowMasterList()
	local list = {}

	for i, v in pairs(self._masterList) do
		if v:isShow() then
			table.insert(list, v)
		end
	end

	for i, v in pairs(self._masterLockList) do
		if v:isShow() then
			table.insert(list, v)
		end
	end

	table.sort(list, function(a, b)
		return a:getMasterOrder() < b:getMasterOrder()
	end)

	return list
end
