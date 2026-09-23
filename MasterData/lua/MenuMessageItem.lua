
function Refresh(_data)
	local msg = _data.content
	if msg ~= "" then
		local str = _data.name .. ":"
		if string.sub(msg, 1, 1) == "/" then
			local strs = StringUtil:split(msg, "/")
			local cfgs = Cfgs.CfgFriendFace:GetAll()		
			for _, cfg in ipairs(cfgs) do
				if cfg.icon == strs[1] then
					str = str .. "[" .. cfg.smallName .. "]"
					break
				end
			end			
		else
			str = str .. _data.content
		end
		CSAPI.SetText(txtMessage, str or "")
	else
		LogError("找不到内容!")
	end
	
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
txtMessage=nil;
view=nil;
end
----#End#----