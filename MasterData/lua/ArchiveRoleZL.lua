--资料
local itemPath = "Archive2/ArchiveRoleZLItem"
local itemPath2 = "Archive2/ArchiveRoleZLItem2"
--卡牌角色资料
function Refresh(_data)
	data = _data
	cfg = data:GetCfg()
	if(data and cfg) then
		InitData()
		--SetItems()
		--SetStoryItem()
		SetInfo()
	end
end

function InitData()
	datas = {}
	local b = true
	local curLv = data:GetLv() or 1
	
	--名字
	AddData(cfg.sName)
	--所属阵营
	local _teamCfg = Cfgs.CfgTeamEnum:GetByID(cfg.sTeam)
	AddData(_teamCfg.sName)
	--邂逅
	local timer = data:GetCreateTime()
	timer = TimeUtil:GetTimeHMS(timer, "%Y/%m/%d")
	AddData(timer)	
	--性别
	local sexCfg = Cfgs.CfgGenDerEnum:GetByID(cfg.sSex)
	local sexName = sexCfg and sexCfg.sName or ""
	AddData(sexName)	
	--血型
	--b = cfg.nBloodTypeLv < data:GetLv()
	AddData(cfg.sBloodType)	
	--出生地
	--b = cfg.nBirthPlaceLv < curLv
	local TerritoryCfg = Cfgs.CfgTerritoryEnum:GetByID(cfg.sBirthPlace)
	local territoryCfgName = TerritoryCfg and TerritoryCfg.sName or ""
	AddData(territoryCfgName)	
	--生日/年龄
	--local b = cfg.nBirthDayLv < curLv
	AddData(cfg.sBirthDay .. "·" .. cfg.sAge)	
	--年龄
	--b = cfg.nAgeLv < curLv
	--AddData(cfg.sAge)	
	--三围
	--b = cfg.nStatureLv < data:GetLv()
	AddData(cfg.sStature)
	--身高
	--b = cfg.nHeightLv < data:GetLv()
	AddData(cfg.sHeight .. "/" .. cfg.sWeight)
	--体重
	--b = cfg.nWeight < data:GetLv()
	--AddData(cfg.sWeight)
	--兴趣
	--b = cfg.nInterestLv < data:GetLv()
	AddData(cfg.sInterest)
	--喜欢
	--b = cfg.nHoppyLv < data:GetLv()
	AddData(cfg.sHoppy)	
	--讨厌
	--b = cfg.nHateLv < data:GetLv()
	AddData(cfg.sHate)	
	--故事
	--b = cfg.nStoryLv < data:GetLv()
	AddData("")	
	
	AddData(cfg.sStory)
	--代号
	--AddData(StringConstant.cRole_5[2], StringUtil:SetColor(cfg.sAliasName, "yellow"))
end

function AddData(_str1)
	table.insert(datas, _str1)
end

function SetInfo()
	local str = ""
	for i, v in ipairs(datas) do
		-- if(i <= #StringConstant.cRole_5) then
		-- 	str = StringConstant.cRole_5[i]
		-- 	ZYUtil:SetText(this["txt" .. i], str .. "：" .. v)
		-- else
		-- 	ZYUtil:SetText(this["txt" .. i], v)
		-- end
	end
end

-- function AddData(_str1, _str2, _isOpen)
-- 	_isOpen = _isOpen == nil and true or _isOpen
-- 	local data = {str1 = _str1 .. "：", str2 = _str2, isOpen = _isOpen}
-- 	table.insert(datas, data)
-- end
-- function SetItems()
-- 	items = items or {}
-- 	for i = #datas, #items do
-- 		CSAPI.SetGOActive(items[i].gameObject, false)
-- 	end
-- 	for i = 1, #datas - 1 do
-- 		local _data = datas[i]
-- 		if(#items >= i) then
-- 			CSAPI.SetGOActive(items[i].gameObject, true)
-- 			items[i].Refresh(_data)
-- 		else
-- 			ResUtil:CreateUIGOAsync(itemPath, Content, function(go)
-- 				local item = ComUtil.GetLuaTable(go)
-- 				item.Refresh(_data)
-- 				table.insert(items, item)
-- 			end)
-- 		end
-- 	end
-- end
-- function SetStoryItem()
-- 	if(not storyItem) then	
-- 		ResUtil:CreateUIGOAsync(itemPath2, Content, function(go)
-- 			storyItem = ComUtil.GetLuaTable(go)
-- 			storyItem.Refresh(datas[#datas])
-- 		end)
-- 	end
-- end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
Content=nil;
txt1=nil;
txt2=nil;
txt3=nil;
txt4=nil;
txt5=nil;
txt6=nil;
txt7=nil;
txt8=nil;
txt9=nil;
txt10=nil;
txt11=nil;
txt12=nil;
txt13=nil;
txt14=nil;
view=nil;
end
----#End#----