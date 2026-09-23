

function Refresh(_data, _elseData)
	data = _data
	if(data) then
		local type1 = data.data and data.data.type
		local type2 = data:GetCfg() and data:GetCfg().type
		if type1 == "GoodsData" and type2 == ITEM_TYPE.CARD then
			CSAPI.SetGOActive(tIcon,true)
			GridUtil.LoadCIcon(icon,tIcon,data:GetCfg(),false);
		else
			CSAPI.SetGOActive(tIcon,false)
			data:GetIconLoader():Load(icon, data:GetIcon())
		end
	end
end

--点击
function OnClick()
	if this.callBack then
		CSAPI.PlayUISound("ui_generic_click_daoju")
		this.callBack(this)
	end
end

function SetClickCB(func)
	this.callBack = func
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
clickNode=nil;
icon=nil;
view=nil;
end
----#End#----