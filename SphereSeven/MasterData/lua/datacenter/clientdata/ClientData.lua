--[[
-- added by wsh @ 2017-12-05
-- 客户端数据
--]]
---@class ClientData
local ClientData = BaseClass("ClientData", Singleton)

---@param self ClientData
local function __init(self)
	self.guide=false
	self.CGRemove = PlayerPrefs.GetInt("CGRemove")
	self.app_version = CS.GameChannel.ChannelManager.instance.appVersion or "Test"
	self.res_version = CS.GameChannel.ChannelManager.instance.resVersion or "Test"
	self.package_name = CS.GameChannel.ChannelManager.instance.packageName or ChannelType.Test

	-- 测试渠道缓存账号和测试sdk缓存
	self.cacheChannel = PlayerPrefs.GetString("cacheChannel")
	self.testSdk = PlayerPrefs.GetString("testSdk")
	if self.package_name == ChannelType.Test and not string.IsNullOrEmpty(self.cacheChannel) then
		self.package_name = self.cacheChannel
	end
	
	self.UpdateMap= PlayerPrefs.GetString("UpdateMap")
	
	self.uid = PlayerPrefs.GetString("uid"..self.package_name)
	self.password = PlayerPrefs.GetString("password"..self.package_name)
	
	--self.uid = nil
	--self.password = nil
	
	self.login_server_id = PlayerPrefs.GetInt("login_server_id")
	self.server_address = PlayerPrefs.GetString("server_address")
	self.feixiao_server_address = nil
	if CS.GameChannel.ChannelManager.instance.serverInfo ~= nil then
		self.feixiao_server_address = CS.GameChannel.ChannelManager.instance.serverInfo.data.server_url
		self.feixiao_announcement_url = CS.GameChannel.ChannelManager.instance.serverInfo.data.preview_url
		self.feixiao_resource_version = CS.GameChannel.ChannelManager.instance.serverInfo.data.app_resource_version
	end
	--print("feixiao_server_address " .. self.feixiao_server_address)

	--if not PlayerPrefs.HasKey("MapId") then
	--	PlayerPrefs.SetInt("MapId", 0)
	--end
	--self.MapId  = PlayerPrefs.GetInt("MapId")
	if not PlayerPrefs.HasKey("BgmVolume") or not PlayerPrefs.HasKey("SoundVolume")  then
		PlayerPrefs.SetFloat("BgmVolume",0.5)
		PlayerPrefs.SetFloat("SoundVolume",0.5)
		PlayerPrefs.SetFloat("CardVolume",0.5)
		PlayerPrefs.SetInt("BgmIsOn", 1)
		PlayerPrefs.SetInt("SoundIsOn", 1)
		PlayerPrefs.SetInt("CardIsOn", 1)
	end
	self.BgmVolume = PlayerPrefs.GetFloat("BgmVolume")
	self.SoundVolume = PlayerPrefs.GetFloat("SoundVolume")
	self.CardVolume=PlayerPrefs.GetFloat("CardVolume")
	self.BgmIsOn = PlayerPrefs.GetInt("BgmIsOn")
	self.SoundIsOn = PlayerPrefs.GetInt("SoundIsOn")
	self.CardIsOn = PlayerPrefs.GetInt("CardIsOn")

	self.SectionDifficulty = (PlayerPrefs.GetInt("SectionDifficulty") == 0 and {1} or {PlayerPrefs.GetInt("SectionDifficulty")})[1]

	self.CurTeamNo = PlayerPrefs.GetInt("CurTeamNo")

	self.isSkipEvo = PlayerPrefs.GetInt("IsSkipEvo")
	self.isSkipFightSoulMerge = PlayerPrefs.GetInt("IsSkipFightSoulMerge")

	self.isSleepWithMainWife = PlayerPrefs.GetInt("IsSleepWithMainWife")
	
	self.CurLevelId_1 = (PlayerPrefs.GetInt("CurLevelId_1") == 0 and {101} or {PlayerPrefs.GetInt("CurLevelId_1")})[1]
	self.CurLevelId_2 = (PlayerPrefs.GetInt("CurLevelId_2") == 0 and {101} or {PlayerPrefs.GetInt("CurLevelId_2")})[1]
	self.CurLevelId_3 = (PlayerPrefs.GetInt("CurLevelId_3") == 0 and {101} or {PlayerPrefs.GetInt("CurLevelId_3")})[1]
	self.CurLevelDifficulty = (PlayerPrefs.GetInt("CurLevelDifficulty") == 0 and {1} or {PlayerPrefs.GetInt("CurLevelDifficulty")})[1]
	self.CurChapterId = (PlayerPrefs.GetInt("CurChapterId") == 0 and {1} or {PlayerPrefs.GetInt("CurChapterId")})[1]
	self.CurLevelId = self["CurLevelId_"..self.CurLevelDifficulty]

	self.BattleSpeed = PlayerPrefs.GetFloat("BattleSpeed")
	self.AutoBattleValue = (PlayerPrefs.GetInt("AutoBattleValue") == 0 and {0} or {1})[1]
	self.AutoAwakenSkill = PlayerPrefs.GetInt("AutoAwakenSkill")
	self.AutoSkill = PlayerPrefs.GetInt("AutoSkill")

	self.IsOptEnemySkill = PlayerPrefs.GetInt("IsOptEnemySkill") == 1
	self.IsIgnoreCooldown = PlayerPrefs.GetInt("IsIgnoreCooldown") == 1

	if string.IsNullOrEmpty(PlayerPrefs.GetString("CommonEmoj")) then
		PlayerPrefs.SetString("CommonEmoj","{}")
	end
	self.CommonEmoj = cjson.decode(PlayerPrefs.GetString("CommonEmoj"))

	if string.IsNullOrEmpty(PlayerPrefs.GetString("CGName")) then
		PlayerPrefs.SetString("CGName","{}")
	end
	self.CGName = cjson.decode(PlayerPrefs.GetString("CGName"))

	if string.IsNullOrEmpty(PlayerPrefs.GetString("CGHeart")) then
		PlayerPrefs.SetString("CGHeart","{}")
	end
	self.CGHeart = cjson.decode(PlayerPrefs.GetString("CGHeart"))
	
	if string.IsNullOrEmpty(PlayerPrefs.GetString("RewardInfoList")) then
		PlayerPrefs.SetString("RewardInfoList","{}")
	end
	self.RewardInfoList = cjson.decode(PlayerPrefs.GetString("RewardInfoList"))
	


	self.SignInData = PlayerPrefs.GetString("SignInData") or "";

	self.CurSevenStarDiff = PlayerPrefs.GetInt("CurSevenStarDiff")
	self.CurSevenStarDiff = (self.CurSevenStarDiff == 0 and {1} or {self.CurSevenStarDiff})[1]

	self.SevenStarDay = PlayerPrefs.GetInt("SevenStarDay")

	self.CurTestLevelId = PlayerPrefs.GetInt("CurTestLevelId")
	if self.CurTestLevelId == 0 then self:SetTestLevel(1001)   end

	self.CurLordRoadLevelId = PlayerPrefs.GetInt("CurLordRoadLevelId")
	if self.CurLordRoadLevelId == 0 then self:SetLordRoadLevel(101) end

	self.CurLordTowerLevelId = PlayerPrefs.GetInt("CurLordTowerLevelId")
	self.CurLordTowerDifficulty = PlayerPrefs.GetInt("CurLordTowerDifficulty")

	if self.CurLordTowerDifficulty == 0 then
		self.CurLordTowerDifficulty = 1
	end

	if self.CurLordTowerLevelId == 0 then
		self:SetLordTowerLevel(101,self.CurLordTowerDifficulty)
	end
	self.CompletedLordLandLayer = PlayerPrefs.GetInt("CompletedLordLandLayer")
    if self.CompletedLordLandLayer == 0 then
        self:SetLordLandLevel(101)
    end
	self.OpenAll = PlayerPrefs.GetInt("OpenAll")
	self.OffSection = PlayerPrefs.GetInt("OffSection")
	self.CurBattleDemoDifficulty = PlayerPrefs.GetInt("CurBattleDemoDifficulty")
	if self.CurBattleDemoDifficulty == 0 then
		self.CurBattleDemoDifficulty = 1
	end
	
	if string.IsNullOrEmpty(PlayerPrefs.GetString("StoryRecord")) then
		PlayerPrefs.SetString("StoryRecord","{}")
	end
	self.StoryRecord =PlayerPrefs.GetString("StoryRecord")
	self.MainUiId=PlayerPrefs.GetInt("mainUiId")

	if string.IsNullOrEmpty(PlayerPrefs.GetString("CollectMusic")) then
		PlayerPrefs.SetString("CollectMusic","{}")
	end
	self.CollectMusic = PlayerPrefs.GetString("CollectMusic")

	if string.IsNullOrEmpty(PlayerPrefs.GetString("InformState")) then
		PlayerPrefs.SetString("InformState","{}")
	end
	self.InformState = PlayerPrefs.GetString("InformState")

	self.Challenge1Diff = PlayerPrefs.GetInt("Challenge1Diff")
	if self.Challenge1Diff == 0 then
		self:SetChallenge1Diff(1)
	end

	self.Challenge2Diff = PlayerPrefs.GetInt("Challenge2Diff")
	if self.Challenge2Diff == 0 then
		self:SetChallenge2Diff(1)
	end
	if not PlayerPrefs.HasKey("AccountDatas") then
		PlayerPrefs.SetString("AccountDatas","{}")
		self.AccountDatas = PlayerPrefs.GetString("AccountDatas")
		self:RenewalAccountDatas(tostring(self.uid))
	end
	self.AccountDatas = PlayerPrefs.GetString("AccountDatas")

	if not PlayerPrefs.HasKey("LangName") then
		PlayerPrefs.SetString("LangName", CS.GameChannel.ChannelManager.instance.defaultLang)
	end
	self.LangName = PlayerPrefs.GetString("LangName")

	if string.IsNullOrEmpty(PlayerPrefs.GetString("ActivityType")) then
		PlayerPrefs.SetString("ActivityType","{}")
	end
	self.ActivityType = PlayerPrefs.GetString("ActivityType")
	if string.IsNullOrEmpty(PlayerPrefs.GetString("SummonList")) then
		PlayerPrefs.SetString("SummonList","{}")
	end
	self.SummonList = PlayerPrefs.GetString("SummonList")

	if string.IsNullOrEmpty(PlayerPrefs.GetString("Hint")) then
		PlayerPrefs.SetString("Hint","{}")
	end
	--- 特殊处理, 直接默认先解码
	self.hint = cjson.decode(PlayerPrefs.GetString("Hint"))


	if string.IsNullOrEmpty(PlayerPrefs.GetString("Log")) then
		PlayerPrefs.SetString("Log","{}")
	end
	self.log = cjson.decode(PlayerPrefs.GetString("Log"))
end

local function ResetData(self)
	PlayerPrefs.DeleteKey("SectionDifficulty")
	PlayerPrefs.DeleteKey("CurTeamNo")
	PlayerPrefs.DeleteKey("CurLevelId_1")
	PlayerPrefs.DeleteKey("CurLevelId_2")
	PlayerPrefs.DeleteKey("CurLevelId_3")
	PlayerPrefs.DeleteKey("CurLevelDifficulty")
	PlayerPrefs.DeleteKey("CurChapterId")
	PlayerPrefs.DeleteKey("CurSevenStarDiff")
	PlayerPrefs.DeleteKey("SevenStarDay")
	PlayerPrefs.DeleteKey("CurTestLevelId")
	PlayerPrefs.DeleteKey("CurLordRoadLevelId")
	PlayerPrefs.DeleteKey("CurLordTowerLevelId")
	PlayerPrefs.DeleteKey("CompletedLordLandLayer")
	PlayerPrefs.DeleteKey("CurLordTowerDifficulty")
	PlayerPrefs.DeleteKey("OpenAll")
	PlayerPrefs.DeleteKey("OffSection")
	PlayerPrefs.DeleteKey("CurBattleDemoDifficulty")
	PlayerPrefs.DeleteKey("StoryRecord")
	PlayerPrefs.DeleteKey("mainUiId")
	PlayerPrefs.DeleteKey("UpdateMap")
	PlayerPrefs.DeleteKey("IsShowDMBanner")

    self.UpdateMap= PlayerPrefs.GetString("UpdateMap")
	self.SectionDifficulty = (PlayerPrefs.GetInt("SectionDifficulty") == 0 and {1} or {PlayerPrefs.GetInt("SectionDifficulty")})[1]
	self.CurTeamNo = PlayerPrefs.GetInt("CurTeamNo")
	self.CurLevelId_1 = (PlayerPrefs.GetInt("CurLevelId_1") == 0 and {101} or {PlayerPrefs.GetInt("CurLevelId_1")})[1]
	self.CurLevelId_2 = (PlayerPrefs.GetInt("CurLevelId_2") == 0 and {101} or {PlayerPrefs.GetInt("CurLevelId_2")})[1]
	self.CurLevelId_3 = (PlayerPrefs.GetInt("CurLevelId_3") == 0 and {101} or {PlayerPrefs.GetInt("CurLevelId_3")})[1]
	self.CurLevelDifficulty = (PlayerPrefs.GetInt("CurLevelDifficulty") == 0 and {1} or {PlayerPrefs.GetInt("CurLevelDifficulty")})[1]
	self.CurChapterId = (PlayerPrefs.GetInt("CurChapterId") == 0 and {1} or {PlayerPrefs.GetInt("CurChapterId")})[1]
	self.CurLevelId = self["CurLevelId_"..self.CurLevelDifficulty]
	self.CurSevenStarDiff = PlayerPrefs.GetInt("CurSevenStarDiff")
	self.CurSevenStarDiff = (self.CurSevenStarDiff == 0 and {1} or {self.CurSevenStarDiff})[1]
	self.SevenStarDay = PlayerPrefs.GetInt("SevenStarDay")
	self.CurTestLevelId = PlayerPrefs.GetInt("CurTestLevelId")
	if self.CurTestLevelId == 0 then self:SetTestLevel(1001)   end
	self.CurLordRoadLevelId = PlayerPrefs.GetInt("CurLordRoadLevelId")
	if self.CurLordRoadLevelId == 0 then self:SetLordRoadLevel(101) end
	self.CurLordTowerLevelId = PlayerPrefs.GetInt("CurLordTowerLevelId")
	self.CurLordTowerDifficulty = PlayerPrefs.GetInt("CurLordTowerDifficulty")
	if self.CurLordTowerLevelId == 0 then self:SetLordTowerLevel(101,1) end
	self.CompletedLordLandLayer = PlayerPrefs.GetInt("CompletedLordLandLayer")
	if self.CompletedLordLandLayer == 0 then self:SetLordLandLevel(101) end
	self.OpenAll = PlayerPrefs.GetInt("OpenAll")
	self.OffSection = PlayerPrefs.GetInt("OffSection")
	PlayerPrefs.SetString("StoryRecord","{}")
	
	self.StoryRecord = PlayerPrefs.GetString("StoryRecord")
	self.CurBattleDemoDifficulty = 1
	PlayerPrefs.SetString("CollectMusic","{}")
	if string.IsNullOrEmpty(PlayerPrefs.GetString("CollectMusic")) then
		PlayerPrefs.SetString("CollectMusic","{}")
	end
	self.CollectMusic =PlayerPrefs.GetString("CollectMusic")
	self.MainUiId=PlayerPrefs.GetInt("mainUiId")

end

function ClientData.GetVolume(self, typeName)
	if string.IsNullOrEmpty(typeName) then
		return
	end
	if typeName == "BgmVolume" then
		if self.BgmIsOn == 0 then
			return 0
		end
		return self.BgmVolume
	elseif typeName == "SoundVolume" then
		if self.SoundIsOn == 0 then
			return 0
		end
		return self.SoundVolume
	elseif typeName == "CardVolume" then
		if self.CardIsOn == 0 then
			return 0
		end
		return self.CardVolume
	end
end

function ClientData.RenewalAccountDatas(self, uid)
	uid = tostring(uid)
	local AccountList = cjson.decode(self.AccountDatas)
	if AccountList[uid] == nil then
		AccountList[uid] = {}
		AccountList[uid].HomeCardRect = {posX = -2.9, posY = 0,scale = 1}
		AccountList[uid].RoomCardRect = {posX = 0, posY = 0,scale = 1}
		AccountList[uid].mainUiId = self.MainUiId
		AccountList[uid].HomeLive2DMode = 0
		AccountList[uid].RoomLive2DMode = 0
		AccountList[uid].HomeLive2DBgMode = 0
		AccountList[uid].RoomLive2DBgMode = 0
		self.AccountDatas = cjson.encode(AccountList)
		PlayerPrefs.SetString("AccountDatas", self.AccountDatas)
	else
		local id = AccountList[uid]["mainUiId"]
		self.MainUiId = id
		PlayerPrefs.SetInt("mainUiId", id)
	end
end

--local function SetMapId(self,value)
--	self.MapId = value
--	PlayerPrefs.SetInt("MapId", value)
--end

local function SetAccountDatas(self,key,info)
	local uid = tostring(self.uid)
	local AccountList = cjson.decode(self.AccountDatas)
	if AccountList[uid] ~= nil then
		AccountList[uid][key] = info
	else
		self:RenewalAccountDatas(uid)
		AccountList[uid][key] = info
	end
	self.AccountDatas = cjson.encode(AccountList)
	PlayerPrefs.SetString("AccountDatas", self.AccountDatas)
end

local function GetAccountkeyDatas(self,key)
	local AccountList = cjson.decode(self.AccountDatas)
	if AccountList[tostring(self.uid)] == nil then
		self:RenewalAccountDatas(self.uid)
		AccountList = cjson.decode(self.AccountDatas)
	end
	return AccountList[tostring(self.uid)][key]
end

function ClientData.SetStoryRecord(self,chapterId,sectionId,diff)
	local recordInfo = cjson.decode(self.StoryRecord)
	local chapterIdStr = tostring(chapterId)
	if recordInfo[chapterIdStr] == nil then
		local tpSectionId = tonumber(chapterId.."01")
		recordInfo[chapterIdStr] = {}
		recordInfo[chapterIdStr].ChapterId = chapterId
		recordInfo[chapterIdStr].SectionId = {}
		recordInfo[chapterIdStr].SectionId[1] = tpSectionId
		recordInfo[chapterIdStr].SectionId[2] = tpSectionId
		recordInfo[chapterIdStr].SectionId[3] = tpSectionId
		recordInfo[chapterIdStr].Difficulty = 1
	end
	if sectionId ~= nil then
		recordInfo[chapterIdStr].SectionId[diff] = sectionId
	end
	if diff ~= nil then
		recordInfo[chapterIdStr].Difficulty = diff
		DataManager:GetInstance():Broadcast(DataMessageNames.ON_STORY_DIFF_CHG,diff)
	end
	local str = cjson.encode(recordInfo)
	PlayerPrefs.SetString("StoryRecord",str)
	self.StoryRecord = PlayerPrefs.GetString("StoryRecord")
end

function ClientData.GetStoryRecord(self,chapterId)
	local recordInfo = cjson.decode(self.StoryRecord)
	local chapterIdStr = tostring(chapterId)
	if recordInfo[chapterIdStr] == nil then
		local sectionId = tonumber(chapterId.."01")
		recordInfo[chapterIdStr] = {}
		recordInfo[chapterIdStr].ChapterId = chapterId
		recordInfo[chapterIdStr].SectionId = {} 
		recordInfo[chapterIdStr].SectionId[1] = sectionId
		recordInfo[chapterIdStr].SectionId[2] = sectionId
		recordInfo[chapterIdStr].SectionId[3] = sectionId
		recordInfo[chapterIdStr].Difficulty = 1
		self:SetStoryRecord(chapterId,sectionId,1)
	end
	return recordInfo[chapterIdStr]
end

function ClientData.SetLangName(self, name)
	PlayerPrefs.SetString("LangName", name)
	self.LangName = name
end

function ClientData.SetCollectMusic(self,musicName)
	local musicList = cjson.decode(self.CollectMusic)
	if table.any(musicList,function (v) return v == musicName end) then
		musicList["m"..musicName] = nil
	else
		musicList["m"..musicName] = musicName    --转化为json字符串 key不能为数字
	end
	self.CollectMusic = cjson.encode(musicList)
	PlayerPrefs.SetString("CollectMusic",self.CollectMusic)
end

function ClientData.GetCollectMusic(self)
	return cjson.decode(self.CollectMusic)
end

function ClientData.SetInformState(self, Id, AfficheList)
	local informList = cjson.decode(self.InformState)
	if Id and not table.any(informList,function(f) return f == Id end) then
		informList[tostring(Id)] = Id
	elseif AfficheList then--移除删除的公告
		for k, v in pairs(informList) do
			if not table.any(AfficheList,function(h) return h.Id == v end) then
				informList[k] = nil
			end
		end
	end
	self.InformState = cjson.encode(informList)
	PlayerPrefs.SetString("InformState",self.InformState)
end

function ClientData.GetInformState(self)
	return cjson.decode(self.InformState)
end

function ClientData.GetActivityType(self)
	return cjson.decode(self.ActivityType)
end

function ClientData.SetActivityType(self, str, typeList)
	local list = cjson.decode(self.ActivityType)
	if str and not table.any(list,function(f) return f == str end) then
		list[str] = str
	end
	if typeList then
		for k, v in pairs(list) do
			if not table.any(typeList,function(h) return h == v end) then
				list[k] = nil
			end
		end
	end
	self.ActivityType = cjson.encode(list)
	PlayerPrefs.SetString("ActivityType",self.ActivityType)
end

function ClientData.RemoveActivityType(self, str)
	local list = cjson.decode(self.ActivityType)
	if str then
		list[str] = nil
	end
	self.ActivityType = cjson.encode(list)
	PlayerPrefs.SetString("ActivityType", self.ActivityType)
end

function ClientData.GetSummonList(self)
	return cjson.decode(self.SummonList)
end

function ClientData.SetSummonList(self, Id, typeList)
	local list = cjson.decode(self.SummonList)
	if not table.any(list,function(f) return f == Id end) then
		list[tostring(Id)] = Id
	end
	if typeList then
		for k, v in pairs(list) do
			if not table.any(typeList,function(h) return h == v end) then
				list[k] = nil
			end
		end
	end
	self.SummonList = cjson.encode(list)
	PlayerPrefs.SetString("SummonList",self.SummonList)
end

function ClientData.RemoveSummonList(self, Id)
	local list = cjson.decode(self.SummonList)
	if Id then
		list[tostring(Id)] = nil
	end
	self.SummonList = cjson.encode(list)
	PlayerPrefs.SetString("SummonList",self.SummonList)
end

function ClientData.SetSectionTool(self,isOpenAll,isOffSection)
	if isOpenAll == nil then
		isOpenAll = self.OpenAll
	else
		isOpenAll = (isOpenAll == true and {1} or {0})[1]
	end
	isOffSection = (isOffSection == true and {1} or {0})[1]
	PlayerPrefs.SetInt("OpenAll",isOpenAll)
	PlayerPrefs.SetInt("OffSection",isOffSection)
	self.OpenAll = isOpenAll
	self.OffSection = isOffSection 
end

function ClientData.SetTestLevel(self,id)
	PlayerPrefs.SetInt("CurTestLevelId",id)
	self.CurTestLevelId = id
end

function ClientData.SetLordRoadLevel(self,id)
	PlayerPrefs.SetInt("CurLordRoadLevelId",id)
	self.CurLordRoadLevelId = id
end

function ClientData.SetLordTowerLevel(self,id,diff)
	if id ~= nil then
		PlayerPrefs.SetInt("CurLordTowerLevelId",id)
		self.CurLordTowerLevelId = id
	end
	if diff ~= nil then
		PlayerPrefs.SetInt("CurLordTowerDifficulty",diff)
		self.CurLordTowerDifficulty = diff
		self.CurLordTowerLevelId = 101
	else
	end
end

function ClientData.SetLordLandLevel(self,id)
	if id ~= nil then
		PlayerPrefs.SetInt("CompletedLordLandLayer",id)
		self.CompletedLordLandLayer = id
	end
end

function ClientData.SetCurBattleDemoDifficulty(self,diff)
	PlayerPrefs.SetInt("CurBattleDemoDifficulty", diff);
	self.CurBattleDemoDifficulty = diff
end

local function SetSevenStarDay(self,day)
	PlayerPrefs.SetInt("SevenStarDay",day);
	self.SevenStarDay = day
end

local function SetCurSevenStarDiff(self,diff)
	PlayerPrefs.SetInt("CurSevenStarDiff",diff);
	self.CurSevenStarDiff = diff;
end

local function SetCurChapterId(self,id)
	PlayerPrefs.SetInt("CurChapterId",id);
	self.CurChapterId = id;
end

local function SetSectionDifficulty(self,diff)
	PlayerPrefs.SetInt("SectionDifficulty",diff);
	self.SectionDifficulty = diff;
end

local function SetCommonEmoj (self,emojId)
	if table.first(self.CommonEmoj,function(v) return v == emojId  end) == nil then
		self.CommonEmoj["c"..emojId] = emojId
	end
	table.sort(self.CommonEmoj,function(a,b) return self.CommonEmoj[a] == emojId   end)
	PlayerPrefs.SetString("CommonEmoj",cjson.encode(self.CommonEmoj));
end

local function SetCGName (self,name)
	if table.first(self.CGName,function(v) return v == name  end) == nil then
		self.CGName[name] = name
	end
	--table.sort(self.CGName,function(a,b) return self.CGName[a] == emojId   end)
	PlayerPrefs.SetString("CGName",cjson.encode(self.CGName));
end

local function RemoveCGName (self,name)
	if table.first(self.CGName,function(v) return v == name  end) ~= nil and self.CGRemove ~= 10 then
		self.CGName[name] = nil
		PlayerPrefs.SetInt("CGRemove",10)
	else
		PlayerPrefs.SetInt("CGRemove",10)
	end
	--table.sort(self.CGName,function(a,b) return self.CGName[a] == emojId   end)
	PlayerPrefs.SetString("CGName",cjson.encode(self.CGName));
end

local function SetCGHeart (self,name)
	if table.first(self.CGHeart,function(v) return v == name  end) == nil then
		self.CGHeart[name] = name
	end
	--table.sort(self.CGName,function(a,b) return self.CGName[a] == emojId   end)
	PlayerPrefs.SetString("CGHeart",cjson.encode(self.CGHeart));
end

local function SetCGHeartRemove(self,name)
	if table.first(self.CGHeart,function(v) return v == name  end) ~= nil then
		self.CGHeart[name] = nil
	end
	--table.sort(self.CGName,function(a,b) return self.CGName[a] == emojId   end)
	PlayerPrefs.SetString("CGHeart",cjson.encode(self.CGHeart));
end

local function SetSignInData(self,str)
	PlayerPrefs.SetString("SignInData",str);
	self.SignInData = str;
end

local function SetAccountInfo(self, uid, password)
	if PlayerPrefs.GetString("uid"..self.package_name) ~= tostring(uid) then
		print("--切换了账号==所有前端记录数据清空")
		ResetData(self)
		self:RenewalAccountDatas(uid)
	end

	self.uid = uid
	self.password = password
	PlayerPrefs.SetString("uid"..self.package_name, uid)
	PlayerPrefs.SetString("password"..self.package_name, password)
	PlayerPrefs.Save()
	DataManager:GetInstance():Broadcast(DataMessageNames.ON_ACCOUNT_INFO_CHG, uid, password)

	--if uid ~= nil and not string.IsNullOrEmpty(tostring(uid)) and not string.IsNullOrEmpty(password) then
	--	local file = io.open(CS.UnityEngine.Application.persistentDataPath.."//sevenspheretemp","w")
	--	local encode = ZZBase64.encode(tostring(uid)..password)
	--	--local decode = ZZBase64.decode(encode)
	--	file:write(encode)
	--	file:close()
	--end
end

local function SetCurTeamNo(self,curTeamNo)
	self.CurTeamNo = curTeamNo
	PlayerPrefs.SetInt("CurTeamNo",curTeamNo)
end

local function SetCurLevel(self,curLevelId,curLevelDifficulty)
	local diff = curLevelDifficulty or self.CurLevelDifficulty
	if curLevelId ~= nil then
		self["CurLevelId_"..diff] = curLevelId
		PlayerPrefs.SetInt("CurLevelId_"..diff,curLevelId)
	end
	self.CurLevelDifficulty = diff
	PlayerPrefs.SetInt("CurLevelDifficulty",diff)
	self.CurLevelId = self["CurLevelId_"..self.CurLevelDifficulty]
end

local function SetBattleSpeed(self,battleSpeed)
	self.BattleSpeed = battleSpeed
	PlayerPrefs.SetFloat("BattleSpeed",battleSpeed)
end

local function SetAutoBattleValue(self,AutoBattleValue)
	self.AutoBattleValue = AutoBattleValue
	PlayerPrefs.SetInt("AutoBattleValue", AutoBattleValue)
end

local function SetRewardInfoList(self,rewardInfoList)
	self.RewardInfoList = rewardInfoList
	PlayerPrefs.SetString("RewardInfoList",cjson.encode(self.RewardInfoList));
end

local function GetAutoBattleValue(self)
	return PlayerPrefs.GetInt("AutoBattleValue")
end

function ClientData.SetAutoAwakenSkill(self, AutoAwakenSkill)
	self.AutoAwakenSkill = AutoAwakenSkill
	PlayerPrefs.SetInt("AutoAwakenSkill", AutoAwakenSkill)
end

function ClientData.GetAutoAwakenSkill(self)
	return PlayerPrefs.GetInt("AutoAwakenSkill")
end

function ClientData.SetAutoSkill(self, AutoSkill)
	self.AutoSkill = AutoSkill
	PlayerPrefs.SetInt("AutoSkill", AutoSkill)
end

function ClientData.GetAutoSkill(self)
	return PlayerPrefs.GetInt("AutoSkill")
end

local function SetDebugInfo(self,isOptEnemySkill,isIgnoreCooldown)
	self.IsOptEnemySkill = isOptEnemySkill
	self.IsIgnoreCooldown = isIgnoreCooldown
	
	PlayerPrefs.SetInt("IsOptEnemySkill",isOptEnemySkill and 1 or 0)
	PlayerPrefs.SetInt("IsIgnoreCooldown",isIgnoreCooldown and 1 or 0)
end

local function SetUpdateMap(self,data)
	self.UpdateMap = data
	PlayerPrefs.SetString("UpdateMap", data)
end

local function SetIsShowDMBanner(self,isShowDMBanner)
	if isShowDMBanner ~= nil then
		PlayerPrefs.SetInt("IsShowDMBanner",isShowDMBanner)
	end
end

local function GetIsShowDMBanner(self)
	return PlayerPrefs.GetInt("IsShowDMBanner") or 0
end

local function SetIsShowSummon(self,IsShowSummon)
	if IsShowSummon ~= nil then
		PlayerPrefs.SetInt("IsShowSummon",IsShowSummon)
	end
end

local function GetIsShowSummon(self)
	return PlayerPrefs.GetInt("IsShowSummon") or 0
end

local function SetLoginServerID(self, id)
	self.login_server_id = id
	PlayerPrefs.SetInt("login_server_id", id)
	DataManager:GetInstance():Broadcast(DataMessageNames.ON_LOGIN_SERVER_ID_CHG, id)
end

local function SetServerAddress(self, server_address)
	self.server_address = server_address
	PlayerPrefs.SetInt("server_address", server_address)
end

local function SetBgmVolume(self, bgmVolume)
	self.BgmVolume = bgmVolume
	PlayerPrefs.SetFloat("BgmVolume", bgmVolume)
	DataManager:GetInstance():Broadcast(DataMessageNames.ON_BGM_VOLUME_CHG, bgmVolume)
end

local function SetSoundVolume(self, soundVolume)
	self.SoundVolume = soundVolume
	PlayerPrefs.SetFloat("SoundVolume", soundVolume)
	DataManager:GetInstance():Broadcast(DataMessageNames.ON_SOUND_VOLUME_CHG, soundVolume)
end

local function SetCardVolume(self, CardVolume)
	self.CardVolume = CardVolume
	PlayerPrefs.SetFloat("CardVolume", CardVolume)
	DataManager:GetInstance():Broadcast(DataMessageNames.ON_CARD_VOLUME_CHG, CardVolume)
end

local function SetVolumeIson(self, type, isOn)
	if type=="bgm" then	--0..1
		self.BgmIsOn = isOn
		PlayerPrefs.SetInt("BgmIsOn", isOn)
	elseif type=="se" then
		self.SoundIsOn = isOn
		PlayerPrefs.SetInt("SoundIsOn", isOn)
	elseif type=="voice" then
		self.CardIsOn = isOn
		PlayerPrefs.SetInt("CardIsOn", isOn)
	end
end

local function SetMainUiId(self,id)
	self.MainUiId = id
	PlayerPrefs.SetInt("mainUiId",id)
	SetAccountDatas(self,"mainUiId",id)
end

local function GetMainUiId(self)
	return GetAccountkeyDatas(self,"mainUiId")
end

local function SetHomeCardRect(self,info)
	SetAccountDatas(self,"HomeCardRect",info)
end

local function GetHomeCardRect(self)
	--local info = cjson.decode(self.HomeCardRect)
	return GetAccountkeyDatas(self,"HomeCardRect")
end

local function SetRoomCardRect(self,info)
	SetAccountDatas(self,"RoomCardRect",info)
end

local function GetRoomCardRect(self)
	--local info = cjson.decode(self.RoomCardRect)
	return GetAccountkeyDatas(self,"RoomCardRect")
end

local function SetHomeLive2DMode(self, mode)
	--PlayerPrefs.SetInt("HomeLive2DMode", mode)
	SetAccountDatas(self,"HomeLive2DMode",mode)
end

local function GetHomeLive2DMode(self)
	--return PlayerPrefs.GetInt("HomeLive2DMode")
	return GetAccountkeyDatas(self,"HomeLive2DMode")
end

local function SetRoomLive2DMode(self, mode)
	--PlayerPrefs.SetInt("RoomLive2DMode", mode)
	SetAccountDatas(self,"RoomLive2DMode",mode)
end

local function GetRoomLive2DMode(self)
	--return PlayerPrefs.GetInt("RoomLive2DMode")
	return GetAccountkeyDatas(self,"RoomLive2DMode")
end

local function GetHomeLive2DBgMode(self)
	return GetAccountkeyDatas(self,"HomeLive2DBgMode")
end

local function SetHomeLive2DBgMode(self, mode)
	SetAccountDatas(self,"HomeLive2DBgMode",mode)
end

local function GetRoomLive2DBgMode(self)
	return GetAccountkeyDatas(self,"RoomLive2DBgMode")
end

local function SetRoomLive2DBgMode(self, mode)
	SetAccountDatas(self,"RoomLive2DBgMode",mode)
end

local function SetChallenge1Diff(self,diff)
	PlayerPrefs.SetInt("Challenge1Diff",diff)
	self.Challenge1Diff = diff
end
local function GetChallenge1Diff(self)
	return self.Challenge1Diff
end

local function SetChallenge2Diff(self,diff)
	PlayerPrefs.SetInt("Challenge2Diff",diff)
	self.Challenge2Diff = diff
end

local function GetChallenge2Diff(self)
	return self.Challenge2Diff
end

function ClientData.SetChannel(self, text)
	self.cacheChannel = text
	PlayerPrefs.SetString("cacheChannel", text)
end

function ClientData.SetTestSdk(self, isOn)
	local val = isOn and "TestSdk" or ""
	self.testSdk = val
	PlayerPrefs.SetString("testSdk", val)
end

function ClientData:SetHintData(uid, hintName, count)
	local uid = tostring(uid)
	if self.hint[uid] == nil then
		self.hint[uid] = {}
	end

	self.hint[uid][hintName] = count
	PlayerPrefs.SetString("Hint", cjson.encode(self.hint))
end

function ClientData:GetHintData(uid)
	return self.hint[tostring(uid)] or {}
end

function ClientData:SetLogData(log)
	self.log = log
	PlayerPrefs.SetString("Log", cjson.encode(self.log))
end

function ClientData:GetLogData()
	return self.log
end

ClientData.__init = __init
ClientData.SetAccountInfo = SetAccountInfo
ClientData.SetCurTeamNo = SetCurTeamNo
ClientData.SetCurLevel = SetCurLevel
ClientData.SetBattleSpeed = SetBattleSpeed
ClientData.SetAutoBattleValue = SetAutoBattleValue
ClientData.GetAutoBattleValue = GetAutoBattleValue
ClientData.SetDebugInfo = SetDebugInfo
ClientData.SetLoginServerID = SetLoginServerID
ClientData.SetServerAddress = SetServerAddress
ClientData.SetVolumeIson = SetVolumeIson
ClientData.SetBgmVolume = SetBgmVolume
ClientData.SetSoundVolume = SetSoundVolume
ClientData.SetCommonEmoj = SetCommonEmoj
ClientData.SetSignInData = SetSignInData
ClientData.SetSectionDifficulty = SetSectionDifficulty
ClientData.SetCurChapterId = SetCurChapterId
ClientData.SetCurSevenStarDiff = SetCurSevenStarDiff
ClientData.SetSevenStarDay = SetSevenStarDay
ClientData.SetMainUiId=SetMainUiId
ClientData.GetMainUiId=GetMainUiId
ClientData.SetCardVolume=SetCardVolume

ClientData.SetHomeCardRect = SetHomeCardRect
ClientData.GetHomeCardRect = GetHomeCardRect

ClientData.SetRoomCardRect = SetRoomCardRect
ClientData.GetRoomCardRect = GetRoomCardRect

ClientData.SetChallenge1Diff = SetChallenge1Diff
ClientData.GetChallenge1Diff = GetChallenge1Diff
ClientData.RemoveCGName = RemoveCGName
ClientData.SetChallenge2Diff = SetChallenge2Diff
ClientData.GetChallenge2Diff = GetChallenge2Diff
ClientData.SetCGName=SetCGName
ClientData.SetCGHeart=SetCGHeart
ClientData.SetCGHeartRemove = SetCGHeartRemove
ClientData.SetHomeLive2DMode = SetHomeLive2DMode
ClientData.SetRoomLive2DMode = SetRoomLive2DMode
ClientData.GetHomeLive2DMode = GetHomeLive2DMode
ClientData.GetRoomLive2DMode = GetRoomLive2DMode
ClientData.GetHomeLive2DBgMode = GetHomeLive2DBgMode
ClientData.SetHomeLive2DBgMode = SetHomeLive2DBgMode
ClientData.GetRoomLive2DBgMode = GetRoomLive2DBgMode
ClientData.SetRoomLive2DBgMode = SetRoomLive2DBgMode

ClientData.SetRewardInfoList = SetRewardInfoList
ClientData.SetUpdateMap = SetUpdateMap
--ClientData.SetMapId = SetMapId

ClientData.SetIsShowDMBanner = SetIsShowDMBanner
ClientData.GetIsShowDMBanner = GetIsShowDMBanner
ClientData.SetIsShowSummon = SetIsShowSummon
ClientData.GetIsShowSummon = GetIsShowSummon
return ClientData