function Images() {
    const data = ["amun", "seshat", "tutankhamun"]

    return (
        <div className="grid grid-cols-3 divide-x divide-yellow-400 justify-items-center ">
            <div className="h-full w-full grid justify-items-center items-end ">
                <img className="h-auto w-2/6" src={`/img/${data[0]}.svg`} />
            </div>
            <div className="h-full w-full grid justify-items-center items-end">
                <img className="h-auto w-2/6" src={`/img/${data[1]}.svg`} />
            </div>
            <div className="h-full w-full grid justify-items-center items-end">
                <img className="h-auto w-2/6" src={`/img/${data[2]}.svg`} />
            </div>
        </div>
    )
}

export default Images
