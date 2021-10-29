import Head from 'next/head'
import Weapons from '../components/Weapons'

export default function Home() {
  return (
    <div className="flex min-h-screen bg-black text-white">
      <Head>
        <title>Egyptian NTF's</title>
        <link rel="icon" href="/favicon.png" />
      </Head>

      <Weapons />

    </div>
  )
}
