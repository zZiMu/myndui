local B, C, L, DB = unpack(select(2, ...))
local cr, cg, cb = DB.ClassColor.r, DB.ClassColor.g, DB.ClassColor.b
if DB.Client ~= "zhCN" then return end

local hx = {
	"Aurora部分模块调整；",
	"团队工具优化；",
	"头像及姓名板调整；",
	"更新背包，为银行添加一个橙装分类；",
	"信息条调整；",
	"更新部分法术；",
	"反光棱镜通报修正；",
	"鼠标提示公会信息修正；",
	"oUF库更新；",
	"优化快速申请功能，右键点击稀有可以搜索队伍；",
	"在预创建新建队伍时，会自动填写你最近搜索的内容；",
	"副本外双击团队工具可以退出队伍；",
	"代码整理优化。",
}

local function changelog()
	local f = CreateFrame("Frame", "NDuiChangeLog", UIParent)
	f:SetPoint("CENTER")
	f:SetScale(1.2)
	f:SetFrameStrata("HIGH")
	B.CreateMF(f)
	B.CreateBD(f)
	B.CreateTex(f)
	B.CreateFS(f, 30, "NDui", true, "TOPLEFT", 10, 25)
	B.CreateFS(f, 14, DB.Version, true, "TOPRIGHT", -10, 12)
	B.CreateFS(f, 16, L["Changelog"], true, "TOP", 0, -10)
	local ll = CreateFrame("Frame", nil, f)
	ll:SetPoint("TOP", -50, -35)
	B.CreateGF(ll, 100, 3, "Horizontal", cr, cg, cb, 0, .7)
	ll:SetFrameStrata("HIGH")
	local lr = CreateFrame("Frame", nil, f)
	lr:SetPoint("TOP", 50, -35)
	B.CreateGF(lr, 100, 3, "Horizontal", cr, cg, cb, .7, 0)
	lr:SetFrameStrata("HIGH")
	local offset = 0
	for n, t in pairs(hx) do
		B.CreateFS(f, 12, n..": "..t, false, "TOPLEFT", 15, -(50 + offset))
		offset = offset + 20
	end
	f:SetSize(400, 60 + offset)
	local close = B.CreateButton(f, 20, 20, "X")
	close:SetPoint("TOPRIGHT", -10, -10)
	close:SetScript("OnClick", function(self) f:Hide() end)
end

NDui:EventFrame{"PLAYER_ENTERING_WORLD"}:SetScript("OnEvent", function(self)
	self:UnregisterAllEvents()
	if HelloWorld then return end
	if not NDuiADB["Changelog"] then NDuiADB["Changelog"] = {} end

	local old1, old2, old3 = string.split(".", NDuiADB["Changelog"].Version or "")
	local cur1, cur2, cur3 = string.split(".", DB.Version)
	if old1 ~= cur1 or old2 ~= cur2 then
		changelog()
		NDuiADB["Changelog"].Version = DB.Version
	end
end)

SlashCmdList["NDUICHANGELOG"] = function()
	if not NDuiChangeLog then changelog() else NDuiChangeLog:Show() end
end
SLASH_NDUICHANGELOG1 = '/ncl'