--奖励箱子
local data = nil
local isGet = false
local isReach = false
local items = {}

function Refresh(_info)
	if _info then
		isGet = _info.isGet
		isReach = _info.isReach
		data = _info.info
		if data then	
			--title
			CSAPI.SetText(txt_title2, data.index .. "")
			--reach
			CSAPI.SetGOActive(reachObj, isReach)
			--target
			CSAPI.SetText(txt_target, data.starNum .. "")
			--rewards
			if data.rewards and #data.rewards > 0 then
				local datas = {}
				for i, v in ipairs(data.rewards) do
					local rData = {id = v[1], num = v[2], type = v[3]}
					table.insert(datas, rData)
				end
				curDatas = datas
				SetItems()
	
				SetRed(GetCanGet())
			end
			
			--sv
			CSAPI.SetScriptEnable(sv, "ScrollRect", #curDatas > 4)
		end
	end
end


function SetItems()
	items = ItemUtil.AddItems("Dungeon/DungeonBoxItem", items, curDatas, svContent)
	for _, item in ipairs(items) do
		item.SetTextShow(isGet)
	end
end

function SetRed(b)
	UIUtil:SetRedPoint(redParent,b,0,0)
end

function GetCanGet()
	local isCanGet = false
	if not isGet and isReach then
		isCanGet = true
	end
	return isCanGet
end 

function IsGet()
	return isGet
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
txt_title1=nil;
txt_title2=nil;
reachObj=nil;
txtReach=nil;
targetObj=nil;
txtTarget=nil;
txt1=nil;
txt_target=nil;
sv=nil;
svContent=nil;
view=nil;
end
----#End#----