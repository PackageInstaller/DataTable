--记录管理
RecordMgr = {};
local this = RecordMgr;

RecordMode =
{
	View = 1,--界面
	DungeonQuit = 2,--副本强退
	Dungeon = 3,--副本地图
	Fight = 4,--战斗
	Count = 5, --统计次数
};

RecordViews =
{
	Plot = 1,--剧情
	Role = 2,--角色
	TeamEdit = 3,--编队界面
	TeamSelect = 4,--编队选人界面
	Buff = 5,--buff列表
	Equip = 6,--装备界面
	Friend = 7, --好友界面
	Matrix = 8, --基地+基地各界面id 1001-1009 冲突勿用
	AD = 9,    --广告
	RoleInfo = 10,--角色详情
	PlotJump=11,--跳过剧情
}

--结束
function this:Save(mode, bTime, customParam)
--	if PlayerClient:IsLog() then
--		bTime = bTime or 0;
--		local eTime = CSAPI.GetRealTime() or 0;

--		local deltaTime = math.ceil(eTime - bTime);
--		if(deltaTime <= 0) then
--			return;
--		end

--		local serverTime = CSAPI.GetServerTime();
--		local curServer = GetCurrentServer();
--		if(not curServer or not curServer.gmSvrIp or not curServer.gmSvrPort) then
--			return;
--		end
--		--LogError(curServer);
--		local url = curServer.sdkUrl ..  "/cross/?cmd=UITimeStatistic&server_id=" .. curServer.index;
--		local param1 = "&uid=" ..(PlayerClient:GetUid() or 0);
--		local param2 = "&btime=" ..(serverTime - deltaTime) .. "&etime=" .. serverTime .. "&ttime=" .. deltaTime;
--		local param3 = "&mode_id=" ..(mode or 0);

--		url = url .. param1 .. param2 .. param3;
--		if(customParam) then
--			url = url .. "&" .. customParam;
--		end	
--		--LogError(url);    
--		CSAPI.WebRequest(url, false);
--	end
end

function this:SaveCount(mode, ui_id, id)
--	if PlayerClient:IsLog() then
--		local serverTime = CSAPI.GetServerTime();
--		local curServer = GetCurrentServer();
--		if(not curServer or not curServer.gmSvrIp or not curServer.gmSvrPort) then
--			return;
--		end
--		--LogError(curServer);
--		--local url = "http://" .. curServer.gmSvrIp .. ":" .. curServer.gmSvrPort .. "/?cmd=ClientProtocol:UITimeStatistic";
--        local url = curServer.sdkUrl ..  "/cross/?cmd=UITimeStatistic&server_id=" .. curServer.index;
--		local param1 = "&uid=" ..(PlayerClient:GetUid() or 0);
--		local param2 = "&btime=" ..(id or 0) .. "&ui_id=" ..(ui_id or 0);
--		local param3 = "&mode_id=" ..(mode or 0);

--		url = url .. param1 .. param2 .. param3;

--		--LogError(url);    
--		CSAPI.WebRequest(url, false);
--	end
end


return this; 