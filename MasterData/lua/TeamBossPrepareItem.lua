function SetIndex(_index)
	index = _index
end
function Refresh(_data, _fzID)
	data = _data
	fzID = _fzID
	--name
	CSAPI.SetText(txtName, data and data.name or "")
	--fighting
	CSAPI.SetText(txtFighting, data and "战斗力：" .. tostring(data.team.performance) or "")
	--grid
	CSAPI.SetGOActive(grid, data ~= nil)
	if(data) then
		SetItems(data.team.data)
	end
	--empty
	CSAPI.SetGOActive(txtEmpty, data == nil)
	--index
	CSAPI.SetText(txtIndex, tostring(index))
	--fz
	CSAPI.SetGOActive(fz,(data and data.uid == fz) and true or false)
	--state
	local str = ""
	if(data) then
		if(data.state == TeamBossTeamState.Prepare) then
			str = "已准备"
		elseif(data.state == TeamBossTeamState.Start) then
			str = "战斗中"
		elseif(data.state == TeamBossTeamState.Finish) then
			str = "战斗结束"
		end
	end
	CSAPI.SetGOActive(state, str ~= "")
	CSAPI.SetText(txtState, str)
end

function SetItems(teamData)
	--封装数据
	local lNewDatas = {}
	local cardDatas = {}
	if(teamData) then
		for i, v in ipairs(teamData) do
			local _card = CharacterCardsData(v.card_info)
			table.insert(cardDatas, _card)
		end
	end	
	for i = 1, 5 do
		if(i <= #cardDatas) then
			table.insert(lNewDatas, cardDatas[i])
		else
			table.insert(lNewDatas, {})
		end
	end	
	
	lTeamGrids = lTeamGrids or {}
	ItemUtil.AddItems("RoleLittleCard/RoleLittleCard", lTeamGrids, lNewDatas, grid)
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
txtName=nil;
txtFighting=nil;
grid=nil;
txtEmpty=nil;
txtIndex=nil;
fz=nil;
state=nil;
txtState=nil;
view=nil;
end
----#End#----