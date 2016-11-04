defmodule Bitcoin do
	def get_data(currency) do
		case "https://bitpay.com/api/rates/#{currency}"  |>  HTTPoison.get |> decode do
		:error ->
			IO.puts "#{currency} is invalid currency"
		data ->
			IO.puts " 1 bitcoin (BTC) =  #{data["rate"]} #{data["name"]} (#{currency})"
		end
	end

	defp decode({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
		body |> Poison.decode! |> interpret
	end
	
	defp decode(_) do
		:error
	end

	defp interpret(decoded_values) do
		try do
			decoded_values
		rescue
			_ -> :error
		end
	end
end
