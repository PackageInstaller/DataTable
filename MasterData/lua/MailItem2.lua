--物品
local data = nil
local cv = nil
local item = nil
function Refresh(_data)
	data = _data
	if data then
		local reward = data.reward
		local skills = reward.eSkills
		local isGet = data.isGet
		--物品
		if item == nil then
			ResUtil:CreateUIGOAsync("Grid/GridItem", itemNode, function(go)
				local goodsData, clickCB = GridFakeData(reward, true)
				clickCB = GridClickFunc.OpenInfoSmiple
				if skills then
					goodsData.data.skills = skills
				end
				local lua = ComUtil.GetLuaTable(go)	
				lua.Refresh(goodsData)
				lua.SetClickCB(clickCB);
				lua.SetCount(reward.num)
				-- lua.SetEquipped(false)
				-- lua.SetIntensify(false)
				-- lua.SetLockActive(false)
				item = lua
			end)
		else		
			local goodsData, clickCB = GridFakeData(reward)
			clickCB = GridClickFunc.OpenInfoSmiple
			if skills then
				goodsData.data.skills = skills
			end
			item.Refresh(goodsData)
			item.SetClickCB(clickCB);
			item.SetCount(reward.num)
			-- item.SetEquipped(false)
			-- item.SetIntensify(false)
			-- item.SetLockActive(false)			
		end
		
		--领取
		SetGET(isGet)
	end
end

function SetGET(_isGet)	
	local isGet = _isGet == MailGetType.Yes
	if not cv then
		cv = ComUtil.GetCom(gameObject, "CanvasGroup")
	end
	CSAPI.SetGOActive(objGet, isGet)
	cv.alpha = isGet and 0.8 or 1
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
itemNode=nil;
objGet=nil;
txt_Get=nil;
view=nil;
end
----#End#----