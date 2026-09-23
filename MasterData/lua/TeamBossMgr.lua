
--isStarting : 等待列表
local TeamBossInfo = require "TeamBossInfo"
local this = MgrRegister("TeamBossMgr")
this.inviteDatas = {} --邀请你的数据 

function this:Init()
	self:Clear()
	self.datas = {}  --未开启
	self.datas2 = {} --参与过
	self.sortTypes = {Sort = {1}, Difficulty = {0}, StateType = {0}}  --排序
	self.ud = 1 --升降
	self.createLimitTime = 0
	self:InitBoss()
	--TODO 应该登录游戏就获取数据，因为如果登录就重连战斗而数据没获取，则在战斗中将无法获取到房间数据
end

function this:Clear()
	self.datas = {}
	self.datas2 = {}
	self.createLimitTime = 0
	self.inviteDatas = {}
end

function this:InitInfos(proto)
	self.createLimitTime = proto.createLimitTime or 0
	local rooms = proto.rooms
	local datas = self:GetDatas(proto.isStarting)
	local arr = self:GetArr(proto.isStarting)
	local len = #arr
	for i = len, 1, - 1 do
		local id = arr[i]:GetId()
		if(rooms[id]) then
			self:UpdateRoomInfo(rooms[id], proto.isStarting) --更新
			rooms[id] = nil
		else
			datas[id] = nil
		end
	end
	for i, v in pairs(rooms) do
		self:AddRoom(v, proto.isStarting) --新增
	end
end


function this:GetDatas(isStarting)
	return isStarting and self.datas or self.datas2
end

function this:GetData(id, isStarting)
	if(id == nil) then
		LogError("获取数据失败！！id无效");
		return nil
	end
	isStarting = isStarting == nil and true or isStarting
	local datas = self:GetDatas(isStarting)
	if(datas) then
		return datas[id]
	end
	return nil
end

--已筛选的数据
function this:GetSortArr(isStarting)
	isStarting = isStarting == nil and true or isStarting
	local newArr = self:GetArr(isStarting, false) --不包含需邀请的房间
	if(isStarting) then
		--未开启的房间需要筛选
		local conditionData = self:GetSortType()
		--筛选
		self:SortDatas(newArr)
		if(#newArr > 1) then
			if(conditionData.Sort[1] == 1) then
				table.sort(newArr, function(a, b)
					return a:CreateTime() < b:CreateTime()
				end)
			else
				table.sort(newArr, function(a, b)
					if(a:GetDifficultIndex() == b:GetDifficultIndex()) then
						return a:CreateTime() < b:CreateTime()                --最先创建的在前
					else
						return a:GetDifficultIndex() < b:GetDifficultIndex() --难度小的在前
					end
				end)
			end
		end
	else
		--参与过的不用筛选
		if(#newArr > 1) then
			table.sort(newArr, function(a, b)
				return a:CreateTime() < b:CreateTime()
			end)
		end
	end
	return newArr
end

function this:SortDatas(newArr)
	--难度
	local rule = self:GetSortType().Difficulty
	if(rule[1] ~= 0) then
		local newRule = {}
		for i, v in ipairs(rule) do
			newRule[v] = v
		end
		local len = #newArr
		for i = len, 1, - 1 do
			if(newRule[newArr[i]:GetDifficultIndex()] == nil) then
				table.remove(newArr, i)
			end
		end
	end
	--状态
	rule = self:GetSortType().StateType
	if(rule[1] ~= 0) then
		local newRule = {}
		for i, v in ipairs(rule) do
			newRule[v] = v
		end
		local len = #newArr
		for i = len, 1, - 1 do
			if(newRule[newArr[i]:GetState()] == nil) then
				table.remove(newArr, i)
			end
		end
	end
end


function this:GetArr(isStarting, isInvite)
	isInvite = isInvite == nil and true or isInvite
	local datas = self:GetDatas(isStarting)
	local arr = {}
	for i, v in pairs(datas) do
		table.insert(arr, v)
	end
	return arr
end

--添加房间数据
function this:AddRoom(newInfo, isStarting)
	isStarting = isStarting == nil and true or isStarting
	local id = newInfo.id
	local info = TeamBossInfo.New()
	info:InitData(newInfo, isStarting)
	if(isStarting) then
		self.datas[id] = info
	else
		self.datas2[id] = info
	end
end

--更新房间数据  newInfo：新数据
function this:UpdateRoomInfo(newInfo, isStarting)
	isStarting = isStarting == nil and true or isStarting
	local id = newInfo.id
	local info = self:GetData(id, isStarting) --旧数据
	if(info) then
		for key, value in pairs(newInfo) do
			if(key == "teams") then
				for n, m in ipairs(value) do
					local teams = info:GetRoles()
					local isAdd = false
					for i, v in ipairs(teams) do
						if(m.uid == v.uid) then
							for p, q in pairs(m) do
								info:GetRoles() [i] [p] = q
							end
							isAdd = true
							break
						end
					end
					if(not isAdd) then
						table.insert(info:GetRoles(), m)
					end
				end
			else
				info:GetData() [key] = value
			end
		end
	else
		self:AddRoom(newInfo, isStarting)
	end
end

--邀请回调 刷新已邀请
function this:RoomInviteRet(proto)
	if(proto.isOk) then
		local info = self:GetData(proto.id)
		if(info) then
			info:RoomInviteRet(proto.uid) --添加已邀请
		end
	end
end

--离开房间
function this:LeaveRoomRet(proto)
	local info = self:GetData(proto.id)
	if(info) then
		if(info:GetCreateId() == proto.uid) then
			--房间解散
			self.datas[proto.id] = nil
			self.createLimitTime = proto.createLimitTime or 0
			EventMgr:Dispatch(EventType.TeamBoss_List) --自己离开时，刷新列表
		else
			info:LeaveRoomRet(proto.uid)
		end
	end
end

----------------------------------////排序相关
--排序类型
function this:GetSortType(_data)
	if(_data) then
		self.sortTypes = _data
	end
	return self.sortTypes
end
--升降类型
function this:GetOrderType(_listType)
	if(_listType) then
		self.ud = _listType
	end
	return self.ud
end

-------------------------------------////boss
--初始化当天boss
function this:InitBoss()
	self.bossID = nil  --boss cfgid 
	self.timeID = nil  --时间段cfgid
	local weekIndex =(CSAPI.GetWeekIndex() == 7) and 0 or(CSAPI.GetWeekIndex() + 1)
	local cfgs = Cfgs.CfgTeamBoss:GetAll()
	for i, v in pairs(cfgs) do
		if(v.timeArr and v.timeArr[weekIndex] ~= 0) then
			self.bossID = v.id
			self.timeID = v.timeArr[weekIndex]
			break
		end
	end
end

--当前是否开启，结束时间，未开启的下一次检测时间戳（当天没有，则延顺到当天0点）
function this:CheckOpen()
	local isOpen, time1, time2 = false, nil, nil
	local curTimeData = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
	if(self.bossID and self.timeID) then
		--当天有boss
		local hour = curTimeData.hour
		local timeArr = Cfgs.CfgTeamBossTimePool:GetByID(self.timeID).timeArr
		for i, v in ipairs(timeArr) do
			if(v[1] <= hour and v[2] > hour) then
				isOpen = true
				time1 = TimeUtil:GetTime2(curTimeData.year, curTimeData.month, curTimeData.day, v[2], 0, 0)
				break
			end
			if(hour < v[1]) then
				time2 = TimeUtil:GetTime2(curTimeData.year, curTimeData.month, curTimeData.day, v[1], 0, 0)
				break
			end
			if(i == #timeArr) then
				time2 = TimeUtil:GetNextDay(curTimeData)
			end
		end
	else
		--当天无boss
		time2 = TimeUtil:GetNextDay(curTimeData)
	end
	return isOpen, time1, time2
end


-------------------------------------////邀请tips
function this:RoomBeInvite(proto)
	self.inviteDatas = self.inviteDatas or {}
	table.insert(self.inviteDatas, proto)
	--只在主场景接收
	local scene	= SceneMgr:GetCurrScene()
	if(scene.key == "MajorCity") then
		if(TimeUtil:GetTime() <(proto.invite_time + g_TeamBossTipsWaitTime)) then
			Tips.ShowInviteTips(proto, InviteTypes.teamBoss)
		end
	end
end

function this:CheckInvite()
	local scene	= SceneMgr:GetCurrScene()
	if(scene.key == "MajorCity") then
		if(self.inviteDatas) then
			for i, v in pairs(self.inviteDatas) do
				if(TimeUtil:GetTime() <(v.invite_time + g_TeamBossTipsWaitTime)) then
					Tips.ShowInviteTips(v)
				end
			end
		end
	end
end



return this 